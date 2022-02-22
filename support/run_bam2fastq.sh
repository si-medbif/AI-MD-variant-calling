#! /bin/bash

SAMPLES=$1

echo ${SAMPLES}

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	fastq="${arr[0]}"
	bam="${arr[1]}"
	fastqsample="${arr[2]}"
	bamsample="${arr[3]}"
	sbatch parabricks_bam2fastq.sh $fastq $bam $fastqsample $bamsample
done
