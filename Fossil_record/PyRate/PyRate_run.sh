# This script run in parallel several pyrate runs from the same set of replicates
# Assuming you have parallel installed 20 CPU will be used
# Occ_gn_Orecto_PyRate.py is the location of your PyRate occurence file (in this case the occurence for genus data including singletons)
# ../../PyRate/PyRate.py is the location of your PyRate launch file
# epochs_rate_shift_5_Myrs.txt is your epoch file for shifts (truncated 5 Myrs in this case)
# Preservation/epochs.txt is your epoch file for preservation

cp ../Data/Data_Occ_gen_Orecto_PyRate.py Genus/Data_Occ_gen_Orecto_PyRate.py

echo "python ../../PyRate/PyRate.py  Genus/Data_Occ_gen_Orecto_PyRate.py -fixShift epochs_rate_shift_5_MA_crisis.txt -j \$1 -qShift Preservation/Genus/epochs_preservation.txt -mG -n 20000000 -s 20000 -N 11" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}
		
cp ../Data/Data_Occ_sp_Orecto_PyRate.py Species/Data_Occ_sp_Orecto_PyRate.py

echo "python ../../PyRate/PyRate.py  Species/Data_Occ_sp_Orecto_PyRate.py -fixShift epochs_rate_shift_5_MA_crisis.txt -j \$1 -qShift Preservation/Species/epochs_preservation.txt -mG -n 20000000 -s 20000 -N 44" > tmp_script.sh
		parallel -j 20 bash tmp_script.sh ::: {1..20}
