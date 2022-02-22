#! /bin/bash

SAMPLES=$1

echo ${SAMPLES}

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	fastq="${arr[0]}"
	bam="${arr[1]}"
	vcf="${arr[2]}"
	tumor="${arr[3]}"
	tumor1="${arr[4]}"
	tumor2="${arr[5]}"
	sbatch parabricks_somatic_tumor_slurm.sh $fastq $bam $vcf $tumor $tumor1 $tumor2	
done
