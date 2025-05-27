# Assess convergence

## Main analyses

### Genus

python assess_run_convergence.py -dir ../Results/Main_analyses/Genus/pyrate_mcmc_logs -ana BDS
Rscript plot_ess.r ../Results/Main_analyses/Genus/pyrate_mcmc_logs/ESS_summary.txt  ../Results/Plot_convergence/Stat_10_MA_Genus.pdf

### Species

python assess_run_convergence.py -dir ../Results/Main_analyses/Species/pyrate_mcmc_logs -ana BDS
Rscript plot_ess.r ../Results/Main_analyses/Species/pyrate_mcmc_logs/ESS_summary.txt  ../Results/Plot_convergence/Stat_10_MA_Species.pdf

## Biogeo

### Genus

#### Outside Tethys

python assess_run_convergence.py -dir ../Results/Biogeo/Genus/outside_Tethys/pyrate_mcmc_logs -ana BDS
Rscript plot_ess.r ../Results/Biogeo/Genus/outside_Tethys/pyrate_mcmc_logs/ESS_summary.txt  ../Results/Biogeo/Genus/outside_Tethys/Stat_10_MA_Genus_outside.pdf

#### Tethys

python assess_run_convergence.py -dir ../Results/Biogeo/Genus/Tethys/pyrate_mcmc_logs -ana BDS
Rscript plot_ess.r ../Results/Biogeo/Genus/Tethys/pyrate_mcmc_logs/ESS_summary.txt  ../Results/Biogeo/Genus/Tethys/Stat_10_MA_Genus_tethys.pdf

### Species

#### Outside Tethys

python assess_run_convergence.py -dir ../Results/Biogeo/Species/outside_Tethys/pyrate_mcmc_logs -ana BDS
Rscript plot_ess.r ../Results/Biogeo/Species/outside_Tethys/pyrate_mcmc_logs/ESS_summary.txt  ../Results/Biogeo/Species/outside_Tethys/Stat_10_MA_Species_outside.pdf

#### Tethys

python assess_run_convergence.py -dir ../Results/Biogeo/Species/Tethys/pyrate_mcmc_logs -ana BDS
Rscript plot_ess.r ../Results/Biogeo/Species/Tethys/pyrate_mcmc_logs/ESS_summary.txt  ../Results/Biogeo/Species/Tethys/Stat_10_MA_Species_tethys.pdf