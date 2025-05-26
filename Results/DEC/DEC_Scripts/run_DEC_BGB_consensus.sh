# Run DEC model (Consensus tree)

### First argument is a logical indicating if the analyses should contain fossil
### Second argument is the number of fossil constraints (0, 2 or 4)
### Third argument is the name of the prefix for the output files

## Adjacency

### No fossil

Rscript DEC_BGB_posterior_distribution.r FALSE 0  Adjacency

### 2 Fossils

Rscript DEC_BGB_posterior_distribution.r FALSE 2 Adjacency_Fossil_2

### 4 Fossils

Rscript DEC_BGB_posterior_distribution.r FALSE 4 Adjacency_Fossil_4

## Dispersal + Adjacency

### No fossil

Rscript DEC_BGB_posterior_distribution.r  TRUE 0 Adjacency_Dispersal

### 2 Fossils

Rscript DEC_BGB_posterior_distribution.r  TRUE 2 Adjacency_Dispersal_Fossil_2

### 4 Fossils

Rscript DEC_BGB_posterior_distribution.r TRUE 4 Adjacency_Dispersal_Fossil_4