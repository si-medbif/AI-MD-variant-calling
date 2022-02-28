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
	tumor1="${arr[3]}"
	normal="${arr[4]}"
	normal1="${arr[5]}"
	sbatch parabricks_strelkamanta_slurm.sh $bam $vcf $tumor $tumor1 $normal $normal1
done
