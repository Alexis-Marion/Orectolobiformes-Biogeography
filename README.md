# Hopping hotspots shaped the global biogeography and diversification of orectolobiform sharks

## Summary 

- [Summary](#Summary)
- [Overview](#Overview)
- [1 Bayesian estimation of deep-time diversification with PyRate](#1-Bayesian-estimation-of-deep-time-diversification-with-PyRate)
	- [1.1 Preservation model](#11-Preservation-model)
	- [1.2 Running PyRate](#12-Running-Pyrate)
	- [1.3 Assess convergence](#13-Assess-convergence)
 	- [1.4 Combining paleontological and neontological data](#14-Combining-paleontological-and-neontological-data)
 	- [1.5 Plotting PyRate results](#15-Plotting-PyRate-results)
- [2 Analyses of historical biogeography](#2-Analyses-of-historical-biogeography)
 	- [2.1 Historical biogeography with DEC](#21-Historical-biogeography-with-DEC)
 		- [2.1.1 Prepare DEC data](#211-Prepare-DEC-data)
		- [2.1.2 DEC analyses](#212-DEC-analyses)
		- [2.1.3 Compute relative likelihood](#213-Compute-relative-likelihood)
  		- [2.1.4 Plotting DEC ancestral range estimates](#214-Plotting-DEC-ancestral-range-estimates)
    - [2.2 Historical biogeography with DEC](#22-Historical-biogeography-with-DEC)
		- [2.2.1 Simulation DES](#221-Simulation-DES)
 		- [2.2.2 Prepare DES data](#222-Prepare-DES-data)
 		- [2.2.3 DES analyses](#223-DES-analyses)
 		- [2.2.4 DES plotting](#224-DES-plotting)
- [3 Additional scripts](#3-Additional-scripts)
- [Reference](#Reference)

2.2 Dispersal Extinction Sampling (DES)

## Overview

<p align="justify"> This repository's purpose is to give a means of replicability to the article "Hopping hotspots shaped the global biogeography and diversification of orectolobiform sharks" but can be generalised to other similar data. All of the presented scripts are written in R language (R Core Team, 2022). Each script is available as both an annotated notebook (.ipynb) and a raw .r file (unannotated). Raw data are in the "Data" directory. </p>


## 1 Bayesian estimation of deep-time diversification with PyRate

`used directory (BDS)`

<p align="justify"> In this first session, we will be using PyRate (Silvestro et al, 2014). PyRate is a program implemented in Python whose aim is to jointly estimate the preservation process, the tempo of origination and extinction of lineages based on their occurrences in the fossil record. Here, we will assume that the PyRate repository with its functions is at the root of the current working directory.</p>

### 1.1 Preservation model

`used directory (Preservation)`

`used script (model_preservation_test.sh, model_drafting.r; model_preservation_test.sh; run_preservation.sh)`

<p align="justify"> One of the main strengths of PyRate is its ability to account for the bias of the fossil record by estimating a preservation process and correcting the estimated age derived from raw occurrence data. Thus, choosing the best-fit preservation model for any PyRate analysis is critical. Fortunately, Silvestro et al. (2019) implemented a likelihood-based approach for preservation model selection. Yet, while this procedure is certainly useful, it is incomplete. Indeed, the first implementation allowed for model selection across HPP, NHPP, TPP and alternative versions of the TPP, with missing bins. However, bin removal occurred only once and was not recursive. Consequently, model selection is incomplete. Here, we corrected and enhanced this procedure by performing model selection on all PyRate replicates (here, 100). Furthermore, we allowed for recursive bin removal, meaning that the best fit TPP model could be a two-bin model, whereas the generating TPP model could be a five-bin model. Model selection is performed with pairwise comparisons of the AICc metrics across all replicates. </p>

### 1.2 Running PyRate

`used directory (PyRate_runs)`

`used script (PyRate_run.sh; PyRate_run_biogeo.sh)`

<p align="justify"> The first script (PyRate_run.sh) provided in this section is rather simple, and runs a BDCS (birth-death with constrained shifts) analysis on 20,000,000 generations on the genus dataset, including singletons, with diversification shifts every 5 Myrs and integrating preservation shifts from the 1.1 section. Here, to be computationally efficient, we choose to parallelise our run on 20 CPUs. The second script is used for estimating regional diversification rates with PyRate BDCS and takes as input a regionally subsetted PyRate dataset (PyRate_run_biogeo.sh).
</p> 

### 1.3 Assess convergence

`used directory (PyRate_convergence)`

`used script (assess_run_convergence.py; plot_ess.r; run_convergence.sh)`

<p align="justify"> PyRate is a Bayesian program, thus, we will consider that a PyRate run is finished when it achieves convergence. A popular metric to evaluate convergence is the ESS (effective sample size), and it is generally considered that when its number is above 200, convergence is achieved. Thus, we assessed convergence on all runs using the "assess_run_convergence.py" script. Furthermore, this script gives additional useful metrics on the run, such as the origination age, extinction age (if including solely extinct taxa), and the proportion of Ts and Te, with ESS above 200. We also provided a graphical output that can be executed using "plot_ess.r". These two scripts can be run sequentially using the "run_convergence.sh" script.

### 1.4 Combining paleontological and neontological data

`used directory (Combining_Ts_Te)`

`used script (Ts_Te_combined.r; Ts_Te_combined_Biogeography.r)`

<p align="justify"> The script used in this section permits to create additional Ts_Te files that can be later used in PyRate. The combination method used here is that of Brée et al. (2022) and consists of extracting the estimated Time for Speciation (Ts) and Time for Extinction (Te) estimated with PyRate, and merging them with the estimated extant taxa age from a dated phylogeny. Additionally, we used the method from Calderón del Cid et al. (2024) for estimating a corrected species age from branch lengths. Here, we did so by extracting the branch length from 100 posterior trees (Marion et al., 2024) of all extant species that are not sampled in the fossil record and merging them with the Ts Te estimated with PyRate. Additionally, these scripts prepare the combination for the DES analyses (#223-DES-analyses). </p>

### 1.5 Plotting PyRate results

`used directory (PyRate_plotting)`

`used script (1-extract_param_from_PyRate_outputs.r; 2-plotting_facilities.r; Plot_rates.r; Q_rate.sh; ltt_creator.sh; master_script_plotting.sh; parse_Q_rates.py; run_plotting.sh)`

<p align="justify"> In this last section, we provided plotting scripts to display graphically each PyRate output. These scripts will take as input the output directory of a regular (BDCS or RJMCMC) PyRate run. They will represent the RTT (origination and extinction), the diversification RTT, the LTT and the QTT. All the aforementioned scripts are managed using the "master_script_plotting.sh" script, which is the only one that is meant to be run by the user. </p>


### 2 Analyses of historical biogeography

### 2.1 Dispersal Extinction Cladogenesis (DEC)

### 2.1.1 Prepare DEC data

`used directory (Prepare_Data)`

`used script (Make_data_DEC.r)`

<p align="justify"> In this section, the provided script permits the automatic preparation of the required files for BioGeoBEARS analyses. By taking a connectivity table, an extant distribution table and a phylogenetic tree as input, this scripts prepare a time-stratified connectivity matrix, a time-stratified dispersal matrix, a time file and an area file for sampled species. </p>

### 2.1.2 DEC analyses

`used directory (DEC_Analyses)`

`used script (DEC_BGB_consensus_tree.r, DEC_BGB_posterior_distribution.r, run_DEC_BGB_consensus.sh, run_DEC_BGB_posterior.sh)`

<p align="justify"> In this section, the provided script permits performing time-stratified DEC analyses with BioGeoBEARS (Matzke, 2014) on a consensus or posterior tree distribution. The scripts permits to allow, no, two or four fossil constraints and the addition of a time-stratified dispersal matrix. Following the completion of DEC, each script will save an output file with the relative probability of the three most likely range states, and the rest of the states represented as "uncertain" with marginal likelihood. </p>

### 2.1.3 Compute relative likelihood

`used directory (Compute_Relative_Likelihood)`

`used script (Prop_maker_BGB.r)`

<p align="justify"> In this section, the provided script permits to compute the ancestral range relative probability on a set of family-level nodes averaged over the results estimated on the posterior tree distribution. </p>

### 2.1.4 Plotting DEC ancestral range estimates

`used directory (ARE_Plotting)`

`used script (ARE_PLOT_BioGeoBears.r, run_plot_ARE.sh)`

<p align="justify"> In this section, the provided script permits to plot the ancestral range estimates obtained on the consensus tree. Here, either the three most likely ranges, or the three most likely ranges with an "uncertain" range state will be plotted. </p>

### 2.2 Dispersal Extinction Sampling (DES)

### 2.2.1 Simulation DES

`used directory (Simulation)`

`used script (SimDes.r, Simulation_DES.sh, Model_selection_(ML)_Simulation.r)`

<p align="justify"> The DES model is a relatively new framework in paleobiology for estimating biogeographic dynamics through time (Silvestro et al., 2016; Hauffe et al., 2023). Thus, few empirical examples have used this model for answering macroevolutionary questions. To assess whether we had the statistical power for accurately estimating rate parameters, we simulated several DES datasets (with the R packagen SimDES; Hauffe et al., 2023) with properties resembling our empirical dataset. We reported the likelihood of accurately recovering the generating model and parameter precision. </p>

### 2.2.2 Prepare DES data

`used directory (Prepare_DES_data)`

`used script (Make_Data_DES.r, DES_input_files.sh)`

<p align="justify"> In this section, the provided scripts permit to prepare a DES occurrence table from a regular occurrence table. </p>

### 2.2.3 DES analyses

`used directory (DES_analyses)`

`used script (run_DES.sh)`

<p align="justify"> In this section, the provided script runs Bayesian DES analyses on four datasets with expected shifts at 66 and 33.9 Myrs ago for 200,000 MCMC generation, each on twenty DES replicates. </p>

### 2.2.4 DES plotting

`used directory (Plot_Bigeo)`

`used script (Plot DES rates.r, plot_DES.sh)`

<p align="justify"> In this section, the provided scripts allow the plotting of biogeographic rate estimates. These scripts require performing both DES analyses **and** regional PyRate analyses. </p>

### 3 Additional scripts

`used directory (Additional_Scripts)`

`used script (Coordinates_per_family.r, Plot_coordinate_&_palaeocoordinate.r)`

<p align="justify"> The following scripts are not related to any analyses, and mainly are used for plotting geographic extinct and extant occurrences (Plot_coordinate_&_palaeocoordinate.r) or paleogeographic estimation per family for extinct taxa (Coordinates_per_family.r). </p>

### Reference

Brée, B., Condamine, F. L., & Guinot, G. (2022). Combining palaeontological and neontological data shows a delayed diversification burst of carcharhiniform sharks likely mediated by environmental change. Scientific Reports, 12(1), 21906.

Calderón del Cid, C., Hauffe, T., Carrillo, J. D., May, M. R., Warnock, R. C., & Silvestro, D. (2024). Challenges in estimating species' age from phylogenetic trees. Global Ecology and Biogeography, 33(10), e13890.

Hauffe, T., Pires, M. M., Quental, T. B., Wilke, T., & Silvestro, D. (2022). A quantitative framework to infer the effect of traits, diversity and environment on dispersal and extinction rates from fossils. Methods in Ecology and Evolution, 13(6), 1201-1213.

Marion, A. F., Condamine, F. L., & Guinot, G. (2024). Sequential trait evolution did not drive deep-time diversification in sharks. Evolution, 78(8), 1405-1425.

Matzke, N. J. (2014). Model selection in historical biogeography reveals that founder-event speciation is a crucial process in island clades. Systematic biology, 63(6), 951-970.

R Core Team (2022). R: A language and environment for statistical computing. R Foundation for statistical computing, Vienna, Austria. URL https://www.R-project.org/.

Silvestro, D., Salamin, N., & Schnitzler, J. (2014). PyRate: a new program to estimate speciation and extinction rates from incomplete fossil data. Methods in Ecology and Evolution, 5(10), 1126-1131.

Silvestro, D., Salamin, N., Antonelli, A., & Meyer, X. (2019). Improved estimation of macroevolutionary rates from fossil data using a Bayesian framework. Paleobiology, 45(4), 546-570.

Silvestro, D., Zizka, A., Bacon, C. D., Cascales-Minana, B., Salamin, N., & Antonelli, A. (2016). Fossil biogeography: a new model to infer dispersal, extinction and sampling from palaeontological data. Philosophical Transactions of the Royal Society B: Biological Sciences, 371(1691), 20150225.
