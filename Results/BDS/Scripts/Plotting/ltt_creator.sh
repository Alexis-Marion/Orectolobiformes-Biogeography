python ../../../PyRate/PyRate.py -ginput $1 -b $2

mkdir $3
mkdir temp


for file in $1/*se_est.txt; do
	echo $file
	cp $file temp/
	python ../../../PyRate/PyRate.py -d temp/*se_est.txt -ltt 1
	mv temp/*ltt.txt $3
	rm temp/*
done
rm -r temp
