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
                sbatch parabricks_bammetrics.sh $bam $tumor
                normal="${arr[6]}"
                sbatch parabricks_bammetrics.sh $bam $normal
	elif [[ ${#arr[@]} -eq 6 ]]
	then
		bam="${arr[1]}"
		tumor="${arr[3]}"
		sbatch parabricks_bammetrics.sh $bam $tumor
        else
                bam="${arr[0]}"
                sample="${arr[1]}"
                sbatch parabricks_bammetrics.sh $bam $sample
        fi
done
