#! /bin/bash

SAMPLES=$1

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
        if [[ ${#arr[@]} -eq 9 ]]
        then
                bam="${arr[1]}"
                vcf="${arr[2]}"
                tumor="${arr[3]}"
                normal="${arr[6]}"
        else
                bam="${arr[0]}"
                vcf="${arr[1]}"
                tumor="${arr[2]}"
                normal="${arr[3]}"
        fi
	sbatch parabricks_strelkamanta_slurm.sh $bam $vcf $tumor $normal
done
