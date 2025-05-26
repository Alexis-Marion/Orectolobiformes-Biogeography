# Run the bayesian implementation of the Dispersal Extinction Sampling (DES) model

## Genus

echo "python ../../PyRate/PyRateDES.py -d ../Analysis_Bayesian/gen/gen_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 200000 -s 20 -p 100000" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}

## Species

echo "python ../../PyRate/PyRateDES.py -d ../Analysis_Bayesian/sp/sp_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 200000 -s 20 -p 100000" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}

## Species combined (Brée et al., 2022)

echo "python ../../PyRate/PyRateDES.py -d ../Analysis_Bayesian/sp_combined/sp_combined_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 200000 -s 20 -p 100000" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}

## Species combined CDD (Calderón del Cid, et al., 2024)

echo "python ../../PyRate/PyRateDES.py -d ../Analysis_Bayesian/sp_combined_CDD/sp_combined_CDD_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 200000 -s 20 -p 100000" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}

rm tmp_script.sh