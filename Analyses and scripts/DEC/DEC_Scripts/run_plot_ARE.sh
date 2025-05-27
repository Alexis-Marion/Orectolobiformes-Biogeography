# Run plot Ancestral Range Estimation (ARE)

### First argument is the path ancestral range estimates (obtained with DEC_BGB_consensus_tree.r)
### Second argument is the number of desired ARE represented on the plot (3 vs all)
### Third argument is the name of the output file

# All states (uncertainty)

## Adjacency

### No fossil

Rscript ARE_PLOT_BioGeoBears.r ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Adjacency.rds All  ../DEC_Plot/7_area_Adjacency_BGB_DEC.pdf

### 2 Fossils

Rscript ARE_PLOT_BioGeoBears.r ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Adjacency_Fossil_2.rds All ../DEC_Plot/7_area_Adjacency_BGB_2_fossils_DEC.pdf

### 4 Fossils

Rscript ARE_PLOT_BioGeoBears.r ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Adjacency_Fossil_4.rds All ../DEC_Plot/7_area_Adjacency_BGB_4_fossils_DEC.pdf

## Dispersal + Adjacency

### No fossil

Rscript ARE_PLOT_BioGeoBears.r  ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Dispersal_Adjacency.rds All ../DEC_Plot/7_area_Dispersal_Adjacency_DEC.pdf

### 2 Fossils

Rscript ARE_PLOT_BioGeoBears.r  ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Dispersal_Adjacency_Fossil_2.rds All ../DEC_Plot/7_area_Dispersal_Adjacency_2_fossils_DEC.pdf

### 4 Fossils

Rscript ARE_PLOT_BioGeoBears.r ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Dispersal_Adjacency_Fossil_4.rds All ../DEC_Plot/7_area_Dispersal_Adjacency_4_fossils_DEC.pdf

# 3 most likely (no uncertainty)

## Adjacency

### No fossil

Rscript ARE_PLOT_BioGeoBears.r ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Adjacency_Fossil_4.rds 3  ../DEC_Plot/3_most_likely_7_area_Adjacency_BGB_DEC.pdf

### 2 Fossils

Rscript ARE_PLOT_BioGeoBears.r ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Adjacency_Fossil_2.rds 3 ../DEC_Plot/3_most_likely_7_area_Adjacency_BGB_2_fossils_DEC.pdf

### 4 Fossils

Rscript ARE_PLOT_BioGeoBears.r ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Adjacency_Fossil_4.rds 3 ../DEC_Plot/3_most_likely_7_area_Adjacency_BGB_4_fossils_DEC.pdf

## Dispersal + Adjacency

### No fossil

Rscript ARE_PLOT_BioGeoBears.r  ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Dispersal_Adjacency.rds 3 ../DEC_Plot/3_most_likely_7_area_Dispersal_Adjacency_DEC.pdf

### 2 Fossils

Rscript ARE_PLOT_BioGeoBears.r  ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Dispersal_Adjacency_Fossil_2.rds 3 ../DEC_Plot/3_most_likely_7_area_Dispersal_Adjacency_2_fossils_DEC.pdf

### 4 Fossils

Rscript ARE_PLOT_BioGeoBears.r ../DEC_Results/Consensus_tree/Ancestral_range/ancestral_range_DEC_Dispersal_Adjacency_Fossil_4.rds 3 ../DEC_Plot/3_most_likely_7_area_Dispersal_Adjacency_4_fossils_DEC.pdf