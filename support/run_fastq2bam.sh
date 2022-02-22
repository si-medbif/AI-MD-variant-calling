#! /bin/bash

SAMPLES=$1

echo ${SAMPLES}

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	fastq="${arr[0]}"
	bam="${arr[1]}"
	tumor="${arr[2]}"
	tumor1="${arr[3]}"
	tumor2="${arr[4]}"
	sbatch parabricks_fastq2bam_slurm.sh $fastq $bam $tumor $tumor1 $tumor2
done
