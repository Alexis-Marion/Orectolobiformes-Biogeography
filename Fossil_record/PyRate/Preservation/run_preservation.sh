# Run the automated detection of the best-fit preservation model

bash model_preservation_test.sh ../../Data/Data_Occ_gen_Orecto_PyRate.py 20 Genus/epochs_preservation.txt

sleep 10

bash model_preservation_test.sh ../../Data/Data_Occ_sp_Orecto_PyRate.py 20 Species/epochs_preservation.txt
