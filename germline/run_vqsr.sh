#! /bin/bash

SAMPLES=$1

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	vcf="${arr[2]}"
	normal="${arr[3]}"
	echo "ERROR: The parabricks command for doing VQSR is currently not working properly."
	#sbatch parabricks_vqsr_slurm.sh $vcf $normal	
done
