#! /bin/bash

SAMPLES=$1

echo ${SAMPLES}

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	vcf="${arr[2]}"
	normal="${arr[3]}"
	sbatch parabricks_vqsr_slurm.sh $vcf $normal	
done
