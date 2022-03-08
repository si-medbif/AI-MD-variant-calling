#! /bin/bash

SAMPLES=$1

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	fastq="${arr[0]}"
	samplefq1="${arr[1]}"
	samplefq2="${arr[2]}"
	sbatch fastqc_singularity.sh $fastq $samplefq1 $samplefq2
done
