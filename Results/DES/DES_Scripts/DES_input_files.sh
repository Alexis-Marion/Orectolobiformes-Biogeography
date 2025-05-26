# Generate DES files

# Genus

python ../../PyRate/PyRateDES.py -fossil ../Input/Gen_extinct_Tethys.txt -recent ../Input/Gen_extant_Tethys.txt -wd ../Analysis_Bayesian/gen/ -filename gen_DES -bin_size 1 -rep 20

# Species

python ../../PyRate/PyRateDES.py -fossil ../Input/Sp_extinct_Tethys.txt -recent ../Input/Sp_extant_Tethys.txt -wd ../Analysis_Bayesian/sp/ -filename sp_DES -bin_size 1 -rep 20

# Species combined

#python ../../PyRate/PyRateDES.py -fossil ../Input/Sp_extinct_Tethys.txt -recent ../Input/Sp_extant_Tethys.txt -wd ../Analysis_Bayesian/sp_combined/ -filename sp_combined_DES_ -bin_size 1 -rep 20

# Species combined CDD

#python ../../PyRate/PyRateDES.py -fossil ../Input/Sp_extinct_Tethys.txt -recent ../Input/Sp_extant_Tethys.txt -wd ../Analysis_Bayesian/sp_combined_CDD/ -filename sp_combined_CDD_DES_ -bin_size 1 -rep 20