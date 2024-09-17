echo "rb DEC_RevBayes_Orectolobiformes_Replicated.Rev --args \$1" > tmp_DEC_script.sh
		parallel -j 20 bash tmp_DEC_script.sh ::: {1..100}