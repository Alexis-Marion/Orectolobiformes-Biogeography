# Orectolobiformes-diversification




Rscript corHMM-ASE-replicated.r ../../raw_data/Squaliformes_posterior_distribution.tree 4 habitat


Rscript corHMM-ASE-replicated.r ../../raw_data/Multi_Squaliformes_fossil_posterior_distribution.tree 4 habitat_fossilized


Rscript corHMM-ASE-replicated.r ../../raw_data/Squaliformes_posterior_distribution.tree 3 bioluminescent


Rscript corHMM-ASE-replicated.r ../../raw_data/Multi_Squaliformes_fossil_posterior_distribution.tree 3 bioluminescent_fossilized


Squaliformes_extant.tree

Rscript corHMM-ASE-consensus.r ../../raw_data/Squaliformes_extant.tree 4 habitat


Rscript corHMM-ASE-consensus.r ../../raw_data/Squaliformes_fossil.tree 4 habitat_fossilized


Rscript corHMM-ASE-consensus.r ../../raw_data/Squaliformes_extant.tree 3 bioluminescent


Rscript corHMM-ASE-consensus.r ../../raw_data/Squaliformes_fossil.tree 3 bioluminescent_fossilized



convert nexus to newick



Then perform the regular ancestral state esimation 


corHMMM done

hOUwie done

OUwie -> 

Rscript OUwie_consensus.r 

Rscript OUwie_consensus.r corHMM/habitat.rds 9 OUwie/habitat.tsv OUwie/habitat.rds

Rscript OUwie_consensus.r corHMM/habitat_fossilized.rds 9 OUwie/habitat_fossilized.tsv OUwie/habitat_fossilized.rds

Rscript OUwie_consensus.r corHMM/bioluminescent.rds 7 OUwie/bioluminescent.tsv OUwie/bioluminescent.rds

Rscript OUwie_consensus.r corHMM/bioluminescent_fossilized.rds 7 OUwie/bioluminescent_fossilized.tsv OUwie/bioluminescent_fossilized.rds



extract results ...

PyRate -> no singleton



bash pp_test/Genus/Corsair_model_preservation_test.sh Datasets/Genus/Occ_gn_Squali_PyRate.py 20
bash pp_test/Species/Corsair_model_preservation_test.sh Datasets/Species/Occ_sp_Squali_PyRate.py 20

bash pp_test/Genus_NS/Corsair_model_preservation_test.sh Datasets/Genus_NS/Occ_gn_Squali_NS_PyRate.py 20
bash pp_test/Species_NS/Corsair_model_preservation_test.sh Datasets/Species_NS/Occ_sp_Squali_NS_PyRate.py 20




echo "Rscript Panova_hOUwie_consensus_habitat_Replicated.r \$1" > tmp_hab_script.sh
		parallel -j 20 bash tmp_hab_script.sh ::: {1..100}


echo "Rscript Panova_hOUwie_consensus_bioluminescence_Replicated.r \$1" > tmp_biol_script.sh
		parallel -j 20 bash tmp_biol_script.sh ::: {1..100}


### R console

source("pyrate_utilities.r ")

extract.ages(file="…/PyRate_file.txt", replicates=N)


bash 


python assess_run_convergence.py -dir Results/Species_NS/5_MA_bins_EXT_EP/pyrate_mcmc_logs/ -ana BDS


Rscript plot_ess.r Results/Species_NS/5_MA_bins_EXT_EP/pyrate_mcmc_logs/ESS_summary.txt Stat_5_MA_NS_EXT_EP_Species.pdf


python assess_run_convergence.py -dir Results/Species_NS/5_MA_bins_EXT_EP_FT/pyrate_mcmc_logs/ -ana BDS


Rscript plot_ess.r Results/Species_NS/5_MA_bins_EXT_EP_FT/pyrate_mcmc_logs/ESS_summary.txt Stat_5_MA_NS_EXT_EP_FT_Species.pdf
