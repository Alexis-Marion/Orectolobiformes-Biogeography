### BDMCMC/RJMCMC

# Paramètres en entrées
# $1 .py occurence file
# $2 BDMCMC / RJMCMC
# $3 number of cpu
# $4 epochs file (preservation rate) 
# $5 number of extant lineage
# $6 epochs file (time shifts)

if [ $2 == BDMCMC ]; then
    echo "python PyRate.py  $1 -A 2 -fixShift $6 -j \$1 -qShift $4 -n 20000000 -s 20000 -mG -N $5 " > tmp_script2.sh # Mise en place d'une commande Python
    parallel -j $3 bash tmp_script2.sh ::: {1..10} # parralélisation de 10 réplicats du script précédent (\$1 variable shell allant de 1 à 10) 
elif [ $2 == RJMCMC ]; then
    echo "python PyRate.py  $1 -A 4 -j \$1 -qShift $4 -n 20000000 -s 20000 -mG -N $5 " > tmp_script2.sh
    parallel -j $3 bash tmp_script2.sh ::: {1..10}
fi
