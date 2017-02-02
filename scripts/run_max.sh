
OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
OUTPUT_FILE=$OUTPUT_DIRECTORY/measurements_`date +%R`.txt

touch $OUTPUT_FILE

TAB=( 10, 50, 100, 500, 1000, 5000, 10000, 50000, 100000, 500000, 1000000 )
TABRep={ 0 0 0 0 0 0 0 0 0 0 0 )
REP=5
TAILLE=${#TAB[@]}

testFin(){
	for i in `seq 1 $TAILLE`; do
		if [ $TABRep[$i]!= 5 ]; then
			return 0;
		fi
	done
	
	return 1;
}

while [testFin != 1]; do
		
		size=$((RANDOM%TAILLE));
		
		while [$TABRep[$size] == 5]; do
			size=$((RANDOM%TAILLE));
		done
		
		$TABRep[$size] = $TABRep[$size] + 1;
		
		echo "Size: $size" >> $OUTPUT_FILE;
		./src/parallelQuicksort0 $size >> $OUTPUT_FILE;
		./src/parallelQuicksort1 $size >> $OUTPUT_FILE;
		./src/parallelQuicksort2 $size >> $OUTPUT_FILE;
		./src/parallelQuicksort3 $size >> $OUTPUT_FILE;
done
