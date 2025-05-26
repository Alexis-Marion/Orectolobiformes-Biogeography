### Simulation

## No shift

# Low

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/No_shift_low/No_shift_low_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/No_shift_low/No_shift_low_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/No_shift_low/No_shift_low_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
	
# Mid
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/No_shift_mid/No_shift_mid_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/No_shift_mid/No_shift_mid_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/No_shift_mid/No_shift_mid_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Combined
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/No_shift_combined/No_shift_combined_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/No_shift_combined/No_shift_combined_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/No_shift_combined/No_shift_combined_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
## One shift

# Low

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/One_shift_low/One_shift_low_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/One_shift_low/One_shift_low_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/One_shift_low/One_shift_low_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
# Mid
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/One_shift_mid/One_shift_mid_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/One_shift_mid/One_shift_mid_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/One_shift_mid/One_shift_mid_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

# Combined
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/One_shift_combined/One_shift_combined_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/One_shift_combined/One_shift_combined_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/One_shift_combined/One_shift_combined_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}		

## Two shifts
		
# Low
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/Two_shifts_low/Two_shifts_low_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/Two_shifts_low/Two_shifts_low_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/Two_shifts_low/Two_shifts_low_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
	
# Mid
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/Two_shifts_mid/Two_shifts_mid_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/Two_shifts_mid/Two_shifts_mid_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/Two_shifts_mid/Two_shifts_mid_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
# Combined
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/Two_shifts_combined/Two_shifts_combined_DES_\$1.txt -TdD -TdE -mG -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
		
echo "python ../PyRate/PyRateDES.py -d Simulation/Input/Two_shifts_combined/Two_shifts_combined_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}

echo "python ../PyRate/PyRateDES.py -d Simulation/Input/Two_shifts_combined/Two_shifts_combined_DES_\$1.txt -TdD -TdE -mG -qtimes 33.9 66 -A 3" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..100}
