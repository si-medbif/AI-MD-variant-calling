#! /bin/bash

SAMPLES=$1

echo ${SAMPLES}

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	bam="${arr[0]}"
	bamsample="${arr[1]}"
	sbatch parabricks_collectmultiplemetrics.sh $bam $bamsample
done
