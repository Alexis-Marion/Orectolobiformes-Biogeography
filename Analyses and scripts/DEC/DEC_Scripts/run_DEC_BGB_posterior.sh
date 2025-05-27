# Run DEC model (Posterior distribution)

### First argument is the number assoicated with the tree taken from the posterior distribution (prefilled)
### Second argument is a logical indicating if the analyses should contain fossil
### Third argument is the number of fossil constraints (0, 2 or 4)
### Fourth argument is the name of the prefix for the output file
## Adjacency

### No fossil

echo "Rscript DEC_BGB_posterior_distribution.r \$1 FALSE 0  Adjacency" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

### 2 Fossils

echo "Rscript DEC_BGB_posterior_distribution.r \$1 FALSE 2 Adjacency_Fossil_2" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

### 4 Fossils

echo "Rscript DEC_BGB_posterior_distribution.r \$1 FALSE 4 Adjacency_Fossil_4" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

## Dispersal + Adjacency

### No fossil

echo "Rscript DEC_BGB_posterior_distribution.r \$1 TRUE 0 Adjacency_Dispersal" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

### 2 Fossils

echo "Rscript DEC_BGB_posterior_distribution.r \$1 TRUE 2 Adjacency_Dispersal_Fossil_2" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

### 4 Fossils

echo "Rscript DEC_BGB_posterior_distribution.r \$1 TRUE 4 Adjacency_Dispersal_Fossil_4" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

rm tmp_script.sh