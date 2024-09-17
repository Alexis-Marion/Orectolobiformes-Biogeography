counter=1
for j in *.log
do
sed -i -e 's/  */ /g' $j
if [ "${counter}" -eq "1" ]
then
counter+=1
first_arr=$(echo "File_name")
first_arr+=$(echo ";")
first_arr+=$(echo "HPP")
first_arr+=$(echo ";")
first_arr+=$(echo "NHPP")
first_arr+=$(echo ";")
first_arr+=$(echo "TPP");
first_arr+=$(echo ";")
max=$(cat $j | grep -o "Removing.*"| cut -f2- -d" "|wc -l)
for i in $(seq 1 $max)
do x=$(echo $i'p;d')
first_arr+=$(cat $j | grep -o "Removing.*"| cut -f2- -d" "| sed $x)
first_arr+=$(echo ";")
done
echo $first_arr >> "tab.tsv"
fi
arrVar=$(echo -e "\n")
arrVar+=$(echo $j)
arrVar+=$(echo ";")
for i in 1 2 3
do arrVar+=$(cat $j | grep -o "AICc scores.*"| cut -f2- -d"["|cut -d "]" -f1|cut -d" " -f$i)
arrVar+=$(echo ";")
done
max=$(cat $j | grep -o "Removing.*"| cut -f2- -d" "|wc -l)
for i in $(seq 1 $max)
do x=$(echo $i'p;d')
arrVar+=$(grep -A1 'Removing' $j | grep -v "Removing"| grep -o "AICs.*"| cut -f2- -d" "|cut -d" " -f1| sed $x)
arrVar+=$(echo ";")
done
echo $arrVar >> "tab.tsv"
done

bckp=$(echo "tab_")
bckp+=$(echo $1)
bckp+=$(echo ".tsb")

cp tab.tsv $bckp

rm *.log