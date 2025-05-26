# This script run in parallel several pyrate runs from the same set of replicates
# Assuming you have parallel installed 20 CPU will be used
# Occ_gn_Orecto_PyRate.py is the location of your PyRate occurence file
# ../../PyRate/PyRate.py is the location of your PyRate launch file
# ../Rate_shifts/rate_shift_crisis.txt is your epoch file for shifts (two shifts at 66 and 33.9 Myrs)
# ../Rate_shifts/rate_shift_crisis.txt is your epoch file for preservation


## Species

### Outside Tethys
		
echo "python ../../PyRate/PyRate.py  ../Results/Biogeo/Species/outside_Tethys/Data_Occ_sp_Orecto_outside_Tethys_PyRate.py -fixShift ../Rate_shifts/rate_shift_crisis.txt -j \$1 -qShift ../Rate_shifts/rate_shift_crisis.txt  -n 20000000 -s 20000 -N 44" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}

## Species

### Tethys
		
echo "python ../../PyRate/PyRate.py  ../Results/Biogeo/Species/Tethys/Data_Occ_sp_Orecto_Tethys_PyRate.py -fixShift ../Rate_shifts/rate_shift_crisis.txt -j \$1 -qShift ../Rate_shifts/rate_shift_crisis.txt  -n 20000000 -s 20000" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}

# Species combined
		
echo "python ../../PyRate/PyRate.py  -d ../Results/Biogeo/Species_combined/\$1_G_KEEP_BDS_se_est.txt -fixShift ../Rate_shifts/rate_shift_crisis.txt -n 20000000 -s 20000 -N 44" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}
		
# Species combined CDD
		
echo "python ../../PyRate/PyRate.py  -d ../Results/Biogeo/Species_combined_CDD/\$1_G_KEEP_BDS_se_est.txt -fixShift ../Rate_shifts/rate_shift_crisis.txt -n 20000000 -s 20000 -N 44" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}

## Genus

### Outside Tethys

echo "python ../../PyRate/PyRate.py  ../Results/Biogeo/Genus/outside_Tethys/Data_Occ_gen_Orecto_outside_Tethys_PyRate.py -fixShift ../Rate_shifts/rate_shift_crisis.txt -j \$1 -qShift ../Rate_shifts/rate_shift_crisis.txt -n 20000000 -s 20000 -N 11" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}

## Genus

### Tethys
		
echo "python ../../PyRate/PyRate.py  ../Results/Biogeo/Genus/Tethys/Data_Occ_gen_Orecto_Tethys_PyRate.py -fixShift ../Rate_shifts/rate_shift_crisis.txt -j \$1 -qShift ../Rate_shifts/rate_shift_crisis.txt  -n 20000000 -s 20000" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}
