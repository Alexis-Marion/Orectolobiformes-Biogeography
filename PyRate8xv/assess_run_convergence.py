import pymc as pm
import numpy as np
import pandas as pd
import os, glob
import argparse

### Enable users to specify directory where log files were stored and bunrnins
p = argparse.ArgumentParser()
p.add_argument('-dir', type=str, help='directory of the mcmc log files')
p.add_argument('-burnins', type=list, default=[.01, .05, .1, .25, .5], help='burnins we want to test')
p.add_argument('-ana', type=str, default='RJMCMC', help='type of analysis carried out (either RJMCMC, BDS or MBD)')
args = p.parse_args()
dir = args.dir
burnins = args.burnins
ana = args.ana


#dir = '/media/lucas/SAMSUNG/Internship_ISEM/Neotropical_Mammals/PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOCENE_OLIGOCENE_order/Rodentia/q_stages/pyrate_mcmc_logs'
#dir = "/media/lucas/SAMSUNG/Internship_ISEM/Neotropical_Mammals/MBD/EOCENE_OLIGOCENE/hand.scale_only/Full"

### Prior param specifications
if ana == "RJMCMC":
    target = 'mcmc.log'
    pattern = 'Grj'
    param_cv = ['posterior', 'prior', 'PP_lik', 'BD_lik']
    param_tot = ['posterior', 'prior', 'PP_lik', 'BD_lik', 'root_age', 'death_age']
if ana == "BDS":
    target = 'mcmc.log'
    pattern = 'G'
    param_cv = ['posterior', 'prior', 'PP_lik', 'BD_lik']
    param_tot = ['posterior', 'prior', 'PP_lik', 'BD_lik', 'root_age', 'death_age']
if ana == "MBD":
    target = 'MBD.log'
    pattern = 'exp'
    param_cv = ['posterior', 'likelihood', 'prior']
    first = pd.read_csv(glob.glob(dir+'/*'+target)[0], sep = '\t')
    param_tot = [i for i in first.columns if i != 'it']


### Burnin specification

#function returning ESS values for a list of parameters given an mcmc log file
def ess_log(log_tbl, burnins = burnins, params = param_cv):
    ESS = pd.DataFrame([i for i in params], columns = ['Parameters'])
    for burnin in burnins:
        log_br = log_tbl[int(burnin*len(log_tbl)-1):] #remove burnin
        n_col = []
        for key in params:
            n_col.append(pm.ess(np.array(log_br[key]), method='mean'))
        ESS.insert(len(ESS.columns), 'Burnin_'+str(burnin), n_col, True)
    return(ESS)

#list of the mcmc log files
list_logs = glob.glob(dir+'/*'+target)

#Choose which burnin value to retain
retained_burnin = {}
for file in list_logs:
    key_name = file.split("/")[-1] #will be the name of the key in retained_burnin
    log_tbl = pd.read_csv(file, sep = '\t')
    ESS = ess_log(log_tbl)
    idx = list(ESS.columns)[1:] #without the 'Params' column
    #locate columns where we have ESS < 200
    ess_mat = np.array(ESS.loc[0:len(ESS), idx])
    not_cv = np.where(ess_mat < 200)[1]
    if len(np.unique(not_cv)) < np.size(ess_mat, axis=1): #if at least one column has all param ESS >= 200
        for col in np.flip(np.unique(not_cv)): #we remove the columns where at least one ESS < 200
#            print(ESS.columns[col+1])
            ESS = ESS.drop(ESS.columns[col+1], axis = 1)
        ESS_sum = ESS.loc[0:len(ESS), list(ESS.columns)[1:]].sum(axis=0) #sum all 4 ESS of the remaining columns
        MAX = ESS_sum[ESS_sum == ESS_sum.max()] #get the maximum value
        key_max = MAX.keys()[0] #name of the corresponding column (i.e 'Burnin_X' with X in burnins)
        brn = float(key_max.split('_')[1]) #go back to the corresponding burnin
        retained_burnin[key_name] = brn
    else:
        #we first check posteriors
        posteriors = ESS.loc[0, idx]
        if np.size(np.where(posteriors < 200)) < len(idx): #if at least one posterior converged decently
            for col in np.flip(np.where(posteriors < 200)):
                print(col)
                ESS = ESS.drop(ESS.columns[col+1], axis = 1)
            ESS_sum = ESS.loc[0:len(ESS), list(ESS.columns)[1:]].sum(axis=0) #sum all 4 ESS of the remaining columns
            MAX = ESS_sum[ESS_sum == ESS_sum.max()] #get the maximum value
            key_max = MAX.keys()[0] #name of the corresponding column (i.e 'Burnin_X' with X in burnins)
            brn = float(key_max.split('_')[1]) #go back to the corresponding burnin
            retained_burnin[key_name] = brn
        else:
            retained_burnin[key_name] = 'NOT_CONVERGED'
#indicating how many runs were found as having converged
V = np.array([i for i in retained_burnin.values()])
if 'NOT_CONVERGED' in V:
    nb_conv = np.shape(np.where(V != 'NOT_CONVERGED'))[1]
else:
    nb_conv = np.shape(V)[0]
print('A total of ' + str(nb_conv) + ' runs were found as having converged.')


### Now, extract mean estimate, min and max 95% HPD and ESS values for posterior, prior, BD_lk, PP_lk, root_age, death_age. Also, add % of Ts and %Te that converged using the burnin we went to characterise

prms = param_tot

#initialise string (header)
STR = 'Run\t'
for p in prms:
    for feature in ['Mean', 'min_HPD', 'max_HPD', 'ESS']:
        STR = STR + feature + '_' + p + '\t'
#add pct TS/TE that converged
if ana == 'RJMCMC' or 'BDS':
    STR = STR + 'Proportion_Ts_CV\tProportion_Te_CV'
#add burnin used
STR = STR + '\tburnin\n'
#loop
for file in list_logs:
    b = retained_burnin[file.split("/")[-1]]
    if b == 'NOT_CONVERGED':
        b = .1
    log_tbl = pd.read_csv(file, sep = '\t')
    # Get the run number (directly as string)
    nm = file.split("/")[-1]
    nm = nm.split("_")
    idx_nb = np.where(np.array(nm) == pattern)[0][0] - 1
    nb = nm[idx_nb]
    STR = STR + nb + '\t' #run 
    # Mean estimate, min, max 94% HPD, ESS
    for p in prms:
        distrib = log_tbl[p]
        distrib = distrib[int(b*len(distrib) - 1):]
        summ = pm.summary(np.array(distrib))
        ESS = ess_log(log_tbl, burnins = [b], params = [p])
        if (summ['mean'][0]) == 0:
        	STR = STR + "0" + "\t" + "0" + "\t" + "0" + "\t"+ "NA" + "\t"
        else:
        	STR = STR + str(summ['mean'][0]) + '\t' + str(summ['hdi_3%'][0]) + '\t' + str(summ['hdi_97%'][0]) + '\t' + str(round(ESS[ESS.columns[1]][0], ndigits=2)) + '\t'
    if ana == 'RJMCMC' or 'BDS':
        #Percentage of TS that converged
        TS = [i for i in log_tbl.columns if 'TS' in i.split('_')]
        ESS_TS = ess_log(log_tbl, burnins = [b], params = TS)
        prop_ts_cv = len([ess for ess in ESS_TS[ESS_TS.columns[1]] if ess >= 200]) / len(ESS_TS)
        STR = STR + str(round(prop_ts_cv, ndigits = 2))
        #Percentage of TE that converged
        TE = [i for i in log_tbl.columns if 'TE' in i.split('_')]
        ESS_TE = ess_log(log_tbl, burnins = [b], params = TE)
        prop_te_cv = len([ess for ess in ESS_TE[ESS_TE.columns[1]] if ess >= 200]) / len(ESS_TE)
        STR = STR + '\t' + str(round(prop_te_cv, ndigits = 2))
    #burnin
    STR = STR + '\t' + str(b) + '\n'
#save the string as .txt
with open(dir+'/ESS_summary.txt', 'w') as file:
    file.write(STR)
file.close()

### Flag all files in the pyrate_mcmc_logs directory that converged
#accessory function analogous to paste0() in R
def paste0(L, sep = "_"):
    s = L[0]
    for i in L[1:]:
        s = s + sep + i
    return(s)
#loop
for name in [i for i in retained_burnin.keys() if retained_burnin[i] != 'NOT_CONVERGED']:
    spl_name = name.split('_')
    if 'KEEP' not in spl_name:
        for f in glob.glob(dir+'/'+paste0(spl_name[:-1])+'*') : # all the files with produced with the run (mcmc.log, ex_rates, sp_rates, sum.txt)
            spl_new = f.split('/')[-1]
            spl_new = spl_new.split('_')
            idx_add = np.where(np.array(spl_new) == pattern)[0] #index after which we'll add the 'KEEP' flag
            new_name_list = spl_new[:(idx_add[0]+1)] + ['KEEP'] + spl_new[(idx_add[0]+1):]
            new_name = paste0(new_name_list)
            os.rename(src=f,
                      dst=dir+'/'+new_name)






