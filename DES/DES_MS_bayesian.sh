# Bayesian

# Sp

# Sp 1

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 1000000 -s 100000 -p 10000 " > tmp_script.sh
		parallel -j 40 bash tmp_script.sh ::: {1..100}

# Gen

# Gen 1

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 1000000 -s 100000 -p 10000 " > tmp_script.sh
		parallel -j 40 bash tmp_script.sh ::: {1..100}
