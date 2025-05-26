# Orectolobiformes-diversification

<p align="justify"> This repository's purpose is to give a means of replicability to the article "Hopping hotspots shaped the global biogeography and diversification of orectolobiform sharks" but can be generalized to other similar data.</p>

## Overview

<p align="justify"> This repository contains scripts for performing the following analyses:

**1**: Analyses of historical biogeography

**2**: Bayesian analyses of the fossil record

### 1 Analyses of historical biogeography

### 1.1 Dispersal Extinction Cladogenesis (DEC)

In this section, you may find all the data and scripts required to perform the DEC model.
The Input section, you may find : the consensus tree (Orectolobiformes_extant_tree.nex); the connectivity matrix (Transition_matrix.txt), the time period file (time_period.txt); the presence-absence file (table_geo.txt) and the posterior tree distribution (posterior_distribution_100_tree_orecto.tree)
The DEC script used for is DEC_extant_species.ipynb (jupyter notebook, written in R)

### 1.2 Dispersal Extinction Sampling (DES)

In this section, you may find the data required to perform a DES analysis.
The Input section contains data for extinct genus (Gen_short_fossil_DES_5vs1.txt) species (Sp_short_fossil_DES_5vs1.txt) and extant genus (Gen_short_actuel_DES_5vs1.txt) and species (Sp_short_actuel_DES_5vs1.txt). Allt the input data are for the 5vs1 scenario (Tethys vs the rest of the world).
Assuming you have access to PyRate in your main directory, the two main scripts are DES_Input.sh (used for generating input DES data) and DES_analysis.sh (perform the DES analysis).

### 2 Bayesian analyses of the fossil record

In this section (PyRate), you will have access to all the scripts and data required to perform a PyRate BDS (Birth-death-skyline) model.
The Input section contains  unformatted data for extinct genus (Data_gen_short.txt) species (Data_sp_short.txt), the formatted data (100 replicates) for extinct genus (Data_gen_short_PyRate.py) species (Data_sp_short_PyRate.py), taxon list for extinct genus (Data_gen_short_TaxonList.txt) and species (Data_sp_short_TaxonList.txt) and the epoch file (epochs.txt).
This section also includes the script required to perform the preservation model selection (Corsair_model_preservation_test.sh; script_pm.sh), performing a PyRate analysis (Analyses_BDMCMC_RJMCMC.sh) and assessing run convergence (assess_run_convergence.py)

### 2.1 Preservation analyses

This first round of analysis is rather straightforward and mainly focused on selecting the best-fit preservation model (based on AIC) for the PyRate run. 

To do so, the user has just to run  and fill in the following parameters (1) .py occurrence file, (2) number of CPU, (3) epochs file, (4) output_directory

At the end of this model selection run, the best-fit model will be presented in a boxplot pdf file.

### 2.2 Birth-death-Skyline model

The second and last round of PyRate analyses is just performing the regular PyRate BDS analysis (assuming you have previously performed preservation model selection). with the script Analyses_BDMCMC_RJMCMC.sh.
This script required as input (1) .py occurence file, (2) the type of analysis (BDMCMC / RJMCMC), (3) number of CPU, (4) epochs file (preservation rate), (5) number of extant lineage and (6) epochs file (time shifts).

When this run is performed, it is highly recommended to asses the convergence of each PyRate run with the script assess_run_convergence.py which require as input (1) the input directory (output from PyRate analysis) (2) the burn-in threshold and (3) the type of analysis (BDS/RJMCMC)
