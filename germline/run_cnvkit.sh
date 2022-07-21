#! /bin/bash

# TODO: Figure out use-cases for autobin and coverage

SAMPLES=$1

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	bam="${arr[1]}"
	vcf="${arr[2]}"
	normal="${arr[3]}"
	sbatch parabricks_cnvkit_slurm.sh $bam $vcf $normal batch
	#sbatch parabricks_cnvkit_slurm.sh $bam $vcf $normal autobin
	#sbatch parabricks_cnvkit_slurm.sh $bam $vcf $normal coverage
done
