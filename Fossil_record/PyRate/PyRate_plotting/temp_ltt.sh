mkdir temp
mkdir ../Species_combined_plot/Output_ltt

for file in ../Species_combined/TS_TE/*se_est.txt; do
	echo $file
	cp $file temp/
	python ../../../PyRate/PyRate.py -d temp/*se_est.txt -ltt 1
	mv temp/*ltt.txt ../Species_combined_plot/Output_ltt/
	rm temp/*
done
