# $1 directory with mcmc log
# $2 burnin
# $3 output directory
# $4 txt file with the geological ages for the preservation rates


for file in $1/*KEEP*mcmc.log
	do
	python ../../../PyRate/PyRate.py -plotQ ${file} -qShift $4 -b $2
	done
mkdir -p $3
mv $1/*_Qrates* $3
    #Parse and save individual q_rates to compile them in a table
python parse_Q_rates.py -dir $3 -out $3/Parsed_Q_rates.tsv

rm $3/*.r
