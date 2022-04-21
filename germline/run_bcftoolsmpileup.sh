#! /bin/bash

SAMPLES=$1

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	bam="${arr[1]}"
	vcf="${arr[2]}"
	normal="${arr[3]}"
	sbatch parabricks_bcftoolsmpileup_slurm.sh $bam $vcf $normal
done
