#! /bin/bash

SAMPLES=$1

echo ${SAMPLES}

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	bam="${arr[0]}"
	vcf="${arr[1]}"
	tumor="${arr[2]}"
	normal="${arr[3]}"
	sbatch parabricks_somaticsniper_slurm.sh $bam $vcf $tumor $normal
done
