#! /bin/bash

SAMPLES=$1

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	vcf="${arr[2]}"
	sample="${arr[3]}"
	sbatch parabricks_genotypegvcf_slurm.sh $vcf $sample
done
