# This script run in parallel several pyrate runs from the same set of replicates
# Assuming you have parallel installed 20 CPU will be used
# Occ_gn_Orecto_PyRate.py is the location of your PyRate occurence file
# ../../PyRate/PyRate.py is the location of your PyRate launch file
# epochs_rate_shift_10_MA_crisis.txt is your epoch file for shifts (truncated 10 Myrs in this case)
# Preservation/epochs_preservation.txt is your epoch file for preservation

# Genus

echo "python ../../PyRate/PyRate.py  Results/Main_analyses/Genus/Data_Occ_gen_Orecto_PyRate.py -fixShift ../Rate_shifts/rate_shift_10_MA_crisis.txt -j \$1 -qShift Preservation/Genus/epochs_preservation.txt -mG -n 20000000 -s 20000 -N 11" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}
		
# Species

echo "python ../../PyRate/PyRate.py  Results/Main_analyses/Species/Data_Occ_sp_Orecto_PyRate.py -fixShift ../Rate_shifts/rate_shift_10_MA_crisis.txt -j \$1 -qShift Preservation/Species/epochs_preservation.txt -mG -n 20000000 -s 20000 -N 44" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}
	
# Species combined
		
echo "python ../../PyRate/PyRate.py  -d Results/Main_analyses/Species_combined/Occ_sp_Orecto_combined_\$1_G_KEEP_BDS_se_est.txt -fixShift ../Rate_shifts/rate_shift_10_MA_crisis.txt -n 20000000 -s 20000 -N 44" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}
		
# Species combined CDD

echo "python ../../PyRate/PyRate.py  -d Results/Main_analyses/Species_combined_CDD/Occ_sp_Orecto_combined_\$1_G_KEEP_BDS_se_est.txt -fixShift ../Rate_shifts/rate_shift_10_MA_crisis.txt-n 20000000 -s 20000 -N 44" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}
