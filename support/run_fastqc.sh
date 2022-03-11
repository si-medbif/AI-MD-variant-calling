#! /bin/bash

SAMPLES=$1

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
        if [[ ${#arr[@]} -eq 9 ]]
        then
                fastq="${arr[0]}"
                tumorfq1="${arr[4]}"
                tumorfq2="${arr[5]}"
                sbatch fastqc_singularity.sh $fastq $tumorfq1 $tumorfq2
                normalfq1="${arr[7]}"
                normalfq2="${arr[8]}"
                sbatch fastqc_singularity.sh $fastq $normalfq1 $normalfq2
	elif [[ ${#arr[@]} -eq 6 ]]
	then
		fastq="${arr[0]}"
		samplefq1="${arr[4]}"
		samplefq2="${arr[5]}"
		sbatch fastqc_singularity.sh $fastq $samplefq1 $samplefq2
        else
                fastq="${arr[0]}"
                samplefq1="${arr[1]}"
                samplefq2="${arr[2]}"
                sbatch fastqc_singularity.sh $fastq $samplefq1 $samplefq2
        fi
done
