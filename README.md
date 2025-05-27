# Orectolobiformes-diversification

## Summary 

- [Summary](#Summary)
- [Overview](#Overview)
- [1 Bayesian estimation of deep-time diversification with PyRate](#1-Bayesian-estimation-of-deep-time-diversification-with-PyRate)
	- [1.1 Preservation model](#11-Preservation-model)
	- [1.2 Running PyRate](#12-Running-Pyrate)
	- [1.3 Assess convergence](#13-Assess-convergence)
  - [1.4 Plotting PyRate results](#14-Plotting-PyRate-results)
- [2 Historical biogeography with DEC](#2-Analyses-of-the-fossil-record)
 	- [2.1 Selecting appropriate PyRate models](#21-Selecting-appropriate-PyRate-models)
 	- [2.1 Selecting appropriate PyRate models](#21-Selecting-appropriate-PyRate-models)
	- [2.2 Extracting time for speciation and extinction](#22-Extracting-time-for-speciation-and-extinction)
	- [2.5 Grafting fossils](#25-Grafting-fossils)
- [3 Phylogenetic comparative analyses](#3-Phylogenetic-comparative-analyses)
	- [3.1 Analyses of discrete trait evolution with corHMM](#31-Analyses-of-discrete-trait-evoplution-with-corHMM)
 	- [3.2 Analyses of continuous trait evolution with OUwie and phylogenetic ANOVA](#32-Analyses-of-continuous-trait-evolution-with-OUwie-and-phylogenetic-ANOVA)
  	- [3.3 Joint estimation of discrete and continuous trait evolution with hOUwie](#32-Joint-estimation-of-discrete-and-continuous-trait-evolution-with-hOUwie)
- [Reference](#Reference)

<p align="justify"> This repository's purpose is to give a means of replicability to the article "Hopping hotspots shaped the global biogeography and diversification of orectolobiform sharkss" but can be generalized to other similar data. All of the presented scripts are written in R language (R Core Team, 2022). Each script is available as both an annotated notebook (.ipynb) or a raw .r file (unannotated).
	If you plan to use any of these scripts, please cite "XXX". </p>

 
## Overview

<p align="justify"> This repository contains scripts for performing the following analyses:

**1**: Analyses of historical biogeography

**2**: Bayesian analyses of the fossil record


## 1 Bayesian estimation of deep-time diversification with PyRate

`used directory (PyRate_scripts)`

<p align="justify">  In this first session, we will be using PyRate (Silvestro et al, 2014). PyRate is a program implemented in Python whose aim is to jointly estimate the preservation process, the tempo of origination and extinction of lineages based on their occurrences in the fossil record. Here, we will assume that the PyRate repository with its functions is at the root of the current working directory.</p>

### 1.1 Preservation model

`used directory (Preservation_Test)`

`used script (model_preservation_test.sh, model_drafting.r; run_preservation.sh)`

<p align="justify"> One of the main strengths of PyRate is its ability to account for the bias of the fossil record by estimating a preservation process and correcting the estimated age derived from raw occurrence data. Thus, choosing the best-fit preservation model for any PyRate analysis is critical. Fortunately, Silvestro et al. (2019) implemented a likelihood-based approach for preservation model selection. Yet, while this procedure is certainly useful, it is incomplete. Indeed, the first implementation allowed for model selection across HPP, NHPP, TPP and alternative versions of the TPP, with missing bins. However, bin removal occurred only once and was not recursive. Consequently, model selection is incomplete. Here, we corrected and enhanced this procedure by performing model selection on all PyRate replicates (here, 100). Furthermore, we allowed for recursive bin removal, meaning that the best fit TPP model could be a two-bin model, whereas the generating TPP model could be a five-bin model. Model selection is performed with pairwise comparisons of the AICc metrics across all replicates. </p>

### 1.2 Running PyRate

`used directory (PyRate_runs)`

`used script (PyRate_run.sh)`

<p align="justify"> The script provided in this section is rather simple, and runs a BDCS (birth-death with constrained shifts) analysis on 20,000,000 generations on the genus dataset including singletons, with diversification shifts every 5 Myrs and integrating preservation shifts from the 1.1 section. Here, to be computationally efficient, we choose to parallelise our run on 20 CPU.</p> 

### 1.3 Assess convergence

`used directory (PyRate_convergence)`

`used script (assess_run_convergence.py; plot_ess.r; run_convergence.sh)`

<p align="justify"> PyRate is a Bayesian program, thus we will consider that a PyRate run is finished when it achieves convergence. A popular metric to evaluate convergence is the ESS (effective sample size), and it is generally considered that when its number is above 200, convergence is achieved. Thus, we assessed convergence on all runs using the "assess_run_convergence.py" script. Furthermore, this script gives additional useful metrics on the run, such as the origination age, extinction age (if including solely extinct taxa), and the proportion of Ts and Te, with ESS above 200. We also provided a graphical output that can be executed using "plot_ess.r". These two scripts can be run sequentially using the "run_convergence.sh" script.

### 1.4 Plotting PyRate results

`used directory (PyRate_plotting)`

`used script (1-extract_param_from_PyRate_outputs.r; 2-plotting_facilities.r; Plot_rates.r; Q_rate.sh; ltt_creator.sh; master_script_plotting.sh; parse_Q_rates.py; run_plotting.sh)`

<p align="justify"> In this last section, we provided plotting scripts to display graphically each PyRate output. These scripts will take as input the output directory of a regular (BDCS or RJMCMC) PyRate run. They will represent, the RTT (origination and extinction), the diversification RTT, the LTT and the QTT. All the aforementioned scripts are managed using the "master_script_plotting.sh" script, which is the only one that is meant to be run by the user. </p>


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
