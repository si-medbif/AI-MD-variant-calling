#! /bin/bash

SAMPLES=$1

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
        if [[ ${#arr[@]} -eq 9 ]]
        then
                bam="${arr[1]}"
                tumor="${arr[3]}"
                sbatch parabricks_bammetrics.hg19.sh $bam $tumor WES
                normal="${arr[6]}"
                sbatch parabricks_bammetrics.hg19.sh $bam $normal WES
	elif [[ ${#arr[@]} -eq 6 ]]
	then
		bam="${arr[1]}"
		tumor="${arr[3]}"
		sbatch parabricks_bammetrics.hg19.sh $bam $tumor WES
        else
                bam="${arr[0]}"
                sample="${arr[1]}"
                sbatch parabricks_bammetrics.hg19.sh $bam $sample WES
        fi
done
