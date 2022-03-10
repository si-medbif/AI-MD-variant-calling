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
	normal="${arr[3]}"
	normal1="${arr[4]}"
	normal2="${arr[5]}"
	sbatch parabricks_deepvariant-germline_slurm.sh $fastq $bam $vcf $normal $normal1 $normal2 WES
done