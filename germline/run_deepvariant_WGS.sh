#! /bin/bash

SAMPLES=$1

echo ${SAMPLES}

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
	bam="${arr[1]}"
	vcf="${arr[2]}"
	normal="${arr[3]}"
	sbatch parabricks_deepvariant-germline_slurm.sh $bam $vcf $normal WGS
done
