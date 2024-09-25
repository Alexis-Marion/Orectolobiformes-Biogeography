python assess_run_convergence.py -dir Genus/pyrate_mcmc_logs/ -ana BDS


Rscript plot_ess.r Genus/pyrate_mcmc_logs/ESS_summary.txt Stat_5_MA_EXT_EP_Genus.pdf



python assess_run_convergence.py -dir Species/pyrate_mcmc_logs/ -ana BDS


Rscript plot_ess.r Species/pyrate_mcmc_logs/ESS_summary.txt Stat_5_MA_EXT_EP_Species.pdf


bash master_script_plotting.sh ../Genus/pyrate_mcmc_logs/ ../Preservation/Genus/epochs_preservation.txt 10 ../Genus_plot ../epochs_rate_shift_10_MA_crisis.txt BDS

bash master_script_plotting.sh ../Species/pyrate_mcmc_logs/ ../Preservation/Species/epochs_preservation.txt 10 ../Species_plot ../epochs_rate_shift_10_MA_crisis.txt BDS