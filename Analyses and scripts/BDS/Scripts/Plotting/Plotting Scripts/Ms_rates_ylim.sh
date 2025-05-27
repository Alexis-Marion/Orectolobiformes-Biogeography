##### This is the master script for Corsair Rates
##### It requires several things : 
##### First a directory ($1) where the output of a simple PyRate run
##### Second ($2) a txt file with the geological ages for the preservation rates
##### Third ($3) the number of burnin state you want to discard (see assess_run_convergence.py)
##### Fourth ($4) an output directory for the plotting
##### Fifth ($5) a txt file with the time bins
##### Last ($6) type of analysis

mkdir $4/

## Ltt

mkdir $4/output_ltt
bash ltt_creator.sh $1 $3 $4/output_ltt

## Preservation rates

bash Q_rate.sh $1 $3 $4 $2

## Rtt & Plot

if [ $6 == BDS ]
then
	echo "BDS"
	python ../PyRate/PyRate.py -plot $1 -tag KEEP -b $3
	for file in $1/*rates_RTT.r
	do
		Rscript Plot_rates_ylim.r $file $5 $2 $4/output_ltt/ $4/Parsed_Q_rates.tsv $4/All_in_one_plot.pdf $6
	done
else
	echo "RJMCMC"
	python ../PyRate/PyRate.py -plotRJ $1 -tag KEEP -b $3
	for file in $1/*RTT_plots.r
	do
		Rscript Plot_rates_ylim.r $file $5 $2 $4/output_ltt/ $4/Parsed_Q_rates.tsv $4/All_in_one_plot.pdf $6
	done
fi

