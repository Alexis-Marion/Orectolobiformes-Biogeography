# Generate DES files

# SP 

# 1 Myrs

python ../PyRate/PyRateDES.py -fossil Input/Sp_extinct_Tethys.txt -recent Input/Sp_extant_Tethys.txt -wd Analysis_ML/sp_1/ -filename sp_1_DES -bin_size 1 -rep 20

# GN

# 1 Myrs

python ../PyRate/PyRateDES.py -fossil Input/Gen_extinct_Tethys.txt -recent Input/Gen_extant_Tethys.txt -wd Analysis_ML/gen_1/ -filename gen_1_DES -bin_size 1 -rep 20
