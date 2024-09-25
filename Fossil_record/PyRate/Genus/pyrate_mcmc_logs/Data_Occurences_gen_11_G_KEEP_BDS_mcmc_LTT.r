

pdf(file='../Genus/pyrate_mcmc_logs/Data_Occurences_gen_11_G_KEEP_BDS_mcmc_LTT.pdf',width=0.6*20, height=0.6*10)
title = "Data_Occurences_gen_11_G_KEEP_BDS_mcmc"
ts=c(85.6024424105519, 109.64333123615265,116.35396591501127,187.10640260462444,143.8035128152299,45.95754030433755,156.77366201829312,118.86333044693282,126.93606581425304,55.17594220362681,143.82054565797876,66.04129126545132,170.57530385089396,60.114681759089216,66.59473167620729,185.69054092535802,70.11331604367764,143.22602480148106,88.45484768451442,77.15699724086306,168.46987856516137,62.08280803418824,142.30482433137445,103.4824165167204,66.96333817024602,54.784879494388,171.8626055386658,156.6086913865442,128.06815679373682,53.67695121046833,187.16694415794282,185.15027744863792,158.3238366695365,151.50790029392218,56.98381785005128,69.60046065828729,143.61570995357562,111.62408661012574,51.020614414799056,160.93478536204054,80.2336005172008,56.804875296931776,75.92126134770017,169.01900491465534,77.57670411894455,31.520924719742197,60.25411890864562,47.90498007967978)
te=c(84.20264532567236, 80.18400989859765,81.0081970369643,94.94193956459947,121.85442242358901,0.0,65.92793671399049,71.11229942370366,0.0,36.502388346572104,64.58858434368595,51.48680485226459,165.62376782071783,40.71751401467578,28.50558482382924,168.3707154694037,67.55350293044576,133.9830344540236,0.0,0.0,164.0914205888728,47.12426831607428,133.405195163234,97.93380885822043,0.0,36.73514566394272,61.10380412934087,151.28917944612266,17.224819180442434,0.0,113.26407077841829,119.41402695502235,136.22686573533707,144.9235088334688,37.885420155388516,68.50864538633063,134.1761447986242,33.81042541319627,0.0,143.2688453896609,65.8179566100656,41.262120265136296,0.0,96.70001329690025,65.39499449348634,0.0,39.36182943420304,0.0)
div_traj=c(0, 1,2,3,4,5,6,7,8,7,6,5,6,7,8,9,10,9,8,9,10,11,10,11,12,11,10,9,8,9,10,9,8,9,10,9,10,11,12,11,10,9,10,11,10,9,10,9,10,11,12,11,12,13,12,11,12,13,14,13,12,11,10,11,10,11,12,13,14,15,16,17,16,17,18,17,18,17,16,15,14,13,12,11,12,11,10)
time_events=c(187.16694415794282, 187.10640260462444,185.69054092535802,185.15027744863792,171.8626055386658,170.57530385089396,169.01900491465534,168.46987856516137,168.3707154694037,165.62376782071783,164.0914205888728,160.93478536204054,158.3238366695365,156.77366201829312,156.6086913865442,151.50790029392218,151.28917944612266,144.9235088334688,143.82054565797876,143.8035128152299,143.61570995357562,143.2688453896609,143.22602480148106,142.30482433137445,136.22686573533707,134.1761447986242,133.9830344540236,133.405195163234,128.06815679373682,126.93606581425304,121.85442242358901,119.41402695502235,118.86333044693282,116.35396591501127,113.26407077841829,111.62408661012574,109.64333123615265,103.4824165167204,97.93380885822043,96.70001329690025,94.94193956459947,88.45484768451442,85.6024424105519,84.20264532567236,81.0081970369643,80.2336005172008,80.18400989859765,77.57670411894455,77.15699724086306,75.92126134770017,71.11229942370366,70.11331604367764,69.60046065828729,68.50864538633063,67.55350293044576,66.96333817024602,66.59473167620729,66.04129126545132,65.92793671399049,65.8179566100656,65.39499449348634,64.58858434368595,62.08280803418824,61.10380412934087,60.25411890864562,60.114681759089216,56.98381785005128,56.804875296931776,55.17594220362681,54.784879494388,53.67695121046833,51.48680485226459,51.020614414799056,47.90498007967978,47.12426831607428,45.95754030433755,41.262120265136296,40.71751401467578,39.36182943420304,37.885420155388516,36.73514566394272,36.502388346572104,33.81042541319627,31.520924719742197,28.50558482382924,17.224819180442434,0.0)
                par(mfrow=c(1,2))
                L = length(ts)
                plot(ts, 1:L , xlim=c(-max(ts)-1,0), pch=20, type="n", main=title,xlab="Time (Ma)",ylab="Lineages")
                for (i in 1:L){segments(x0=-te[i],y0=i,x1=-ts[i],y1=i)}    
                t = -time_events
                plot(div_traj ~ t,type="s", main = "Diversity trajectory",xlab="Time (Ma)",ylab="Number of lineages",xlim=c(-max(ts)-1,0))
                abline(v=c(65,200,251,367,445),lty=2,col="gray")
                