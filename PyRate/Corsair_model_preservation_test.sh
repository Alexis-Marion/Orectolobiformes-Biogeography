# Best-fit preservation model

# Input Parameters
# $1 .py occurence file
# $2 number of cpu
# $3 epochs file
# $4 output_directory

cntr=0
declare -i cntr
while [ ! -f $4/result_boxplot.pdf ]; do
		cntr+=1
		echo "$cntr round of optimization"
		echo "python PyRate/PyRate.py  $1 -j \$1 -qShift $3 -mG -PPmodeltest > $4/File\$1.log" > $4/tmp_script.sh # PyRate temporary script
		parallel -j $2 bash $4/tmp_script.sh ::: {1..10} # Run parallel
		bash script_pm.sh $cntr $4
		Rscript model_drafting.r $4/tab.tsv $3 $4
		rm $4/tab.tsv
		rm $4/tmp_script.sh
		sleep 1
done
