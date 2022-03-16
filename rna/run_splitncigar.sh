#! /bin/bash

SAMPLES=$1

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	bam="${arr[1]}"
	normal="${arr[3]}"
	sbatch parabricks_splitncigar_slurm.sh $bam $normal
done
