# Empirical dataset

# Maximum likelihood

# Sp 

# Sp 1

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Gen 1

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Bayesian

# Sp

# Sp 1

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 1000000 -s 1000 -p 10000 " > tmp_script.sh
		parallel -j 40 bash tmp_script.sh ::: {1..100}

# Gen

# Gen 1

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 1000000 -s 1000 -p 10000 " > tmp_script.sh
		parallel -j 40 bash tmp_script.sh ::: {1..100}
