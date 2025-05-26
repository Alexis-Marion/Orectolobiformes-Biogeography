# Orectolobiformes-diversification

<p align="justify"> This repository's purpose is to give a means of replicability to the article "Hopping hotspots shaped the global biogeography and diversification of orectolobiform sharks" but can be generalised to other similar data.</p>

## Overview

<p align="justify"> This repository contains scripts for performing the following analyses:

**1**: Analyses of historical biogeography

**2**: Bayesian analyses of the fossil record

### 1 Analyses of historical biogeography

### 1.1 Dispersal Extinction Cladogenesis (DEC)

In this section, you may find all the data and scripts required to perform the DEC model.

The script for preparing the adjacency/dispersal matrices is Make_data_DEC.ipynb (jupyter notebook, written in R).
The DEC script used to perform the DEC analysis on the consensus tree is DEC_BGB_consensus_tree.ipynb (jupyter notebook, written in R).
There is a similar script for the posterior tree distribution DEC_BGB_posterior_distribution.ipynb (jupyter notebook, written in R).
The script for computing the relative likelihood of each state is Prop_maker_BGB.ipynb (jupyter notebook, written in R).
The script for plotting the ancestral range estimates is ARE_PLOT_BioGeoBears.ipynb (jupyter notebook, written in R).

### 1.2 Dispersal Extinction Sampling (DES)

In this section, you may find the data required to perform a DES analysis.


The Input section contains data for extinct genera (Gen_extinct_Tethys.txt), species (Sp_extinct_Tethys.txt), extant genera (Gen_extant_Tethys.txt) and species (Sp_extant_Tethys.txt).


Assuming you have access to PyRate in your main directory, the two main scripts are DES_input_files.sh (used for generating input DES data) and run_DES.sh (performs the Bayesian DES empirical analysis).

### 2 Bayesian analyses of the fossil record

In this section (PyRate), you will have access to all the scripts and data required to perform a PyRate BDS (Birth-death-skyline) model.
This section also includes the script required to perform the preservation model selection (Corsair_model_preservation_test.sh; script_pm.sh), performing a PyRate analysis (Analyses_BDMCMC_RJMCMC.sh) and assessing run convergence (assess_run_convergence.py)

### 2.1 Preservation analyses

This first round of analysis is rather straightforward and mainly focused on selecting the best-fit preservation model (based on AIC) for the PyRate run. 

To do so, the user has just to run  and fill in the following parameters (1) .py occurrence file, (2) number of CPU, (3) epochs file, (4) output_directory

At the end of this model selection run, the best-fit model will be presented in a boxplot PDF file.

### 2.2 Birth-death-Skyline model

The second and last round of PyRate analyses is  performing the regular PyRate BDS analysis (assuming you have previously performed preservation model selection).
This script required as input (1) .py occurence file, (2) the type of analysis (BDMCMC / RJMCMC), (3) number of CPU, (4) epochs file (preservation rate), (5) number of extant lineage and (6) epochs file (time shifts).

When this run is performed, it is highly recommended to asses the convergence of each PyRate run with the script assess_run_convergence.py which require as input (1) the input directory (output from PyRate analysis) (2) the burn-in threshold and (3) the type of analysis (BDS/RJMCMC)
