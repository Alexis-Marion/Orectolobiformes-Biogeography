# Gen 05

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_05/Two_shifts_gen_05_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_05/Two_shifts_gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_05/Two_shifts_gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_05/Two_shifts_gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_05/Two_shifts_gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

# Gen 1

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_1/Two_shifts_gen_1_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_1/Two_shifts_gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_1/Two_shifts_gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_1/Two_shifts_gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_1/Two_shifts_gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

# Gen 5

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_5/Two_shifts_gen_5_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_5/Two_shifts_gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_5/Two_shifts_gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_5/Two_shifts_gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_5/Two_shifts_gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

# Gen 10

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_10/Two_shifts_gen_10_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_10/Two_shifts_gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_10/Two_shifts_gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_10/Two_shifts_gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_gen_10/Two_shifts_gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

# Sp 05

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_05/Two_shifts_sp_05_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_05/Two_shifts_sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_05/Two_shifts_sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_05/Two_shifts_sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_05/Two_shifts_sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

# Sp 1

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_1/Two_shifts_sp_1_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_1/Two_shifts_sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_1/Two_shifts_sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_1/Two_shifts_sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_1/Two_shifts_sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

# Sp 5

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_5/Two_shifts_sp_5_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_5/Two_shifts_sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_5/Two_shifts_sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_5/Two_shifts_sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_5/Two_shifts_sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

# Sp 10

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_10/Two_shifts_sp_10_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_10/Two_shifts_sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_10/Two_shifts_sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_10/Two_shifts_sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}

echo "python ../PyRate/PyRateDES.py -d Analysis_simulation/Two_shifts_sp_10/Two_shifts_sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..1000}


# Empirical dataset

# Maximum likelihood

# Sp 

# Sp 05

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_05/sp_05_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_05/sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_05/sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_05/sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_05/sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

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

# Sp 5

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_5/sp_5_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_5/sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_5/sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_5/sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_5/sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Sp 10

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_10/sp_10_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_10/sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_10/sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_10/sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/sp_10/sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Gen

# Gen 05

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_05/gen_05_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_05/gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_05/gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_05/gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_05/gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
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

# Gen 5

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_5/gen_5_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_5/gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_5/gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_5/gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_5/gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Gen 10

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_10/gen_10_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_10/gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_10/gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_10/gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_ML/gen_10/gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Bayesian

# Sp 

# Sp 05

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_05/sp_05_DES_\$1.txt -TdD -TdE -mG -n 10000000 -s 1000000 -p 100000" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_05/sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_05/sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_05/sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_05/sp_05_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Sp 1

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_1/sp_1_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Sp 5

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_5/sp_5_DES_\$1.txt -TdD -TdE -mG -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_5/sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_5/sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_5/sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_5/sp_5_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Sp 10

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_10/sp_10_DES_\$1.txt -TdD -TdE -mG -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_10/sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_10/sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_10/sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/sp_10/sp_10_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Gen

# Gen 05

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_05/gen_05_DES_\$1.txt -TdD -TdE -mG -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_05/gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_05/gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_05/gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_05/gen_05_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Gen 1

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_1/gen_1_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Gen 5

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_5/gen_5_DES_\$1.txt -TdD -TdE -mG -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_5/gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_5/gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_5/gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_5/gen_5_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Gen 10

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_10/gen_10_DES_\$1.txt -TdD -TdE -mG -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_10/gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_10/gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_10/gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Analysis_Bayesian/gen_10/gen_10_DES_\$1.txt -TdD -TdE -mG -qtimes 145 100.5 66 33.9 -n 10000000 -s 1000000 -p 100000 " > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

