#! /bin/bash

SAMPLES=$1

echo ${SAMPLES}

LINES=$(cat $SAMPLES)

for line in $LINES
do
	IFS="," read -a arr <<< $line
        if [[ ${#arr[@]} -eq 9 ]]
        then
                fastq="${arr[0]}"
                bam="${arr[1]}"
                tumor="${arr[3]}"
                tumorfq1="${arr[4]}"
                tumorfq2="${arr[5]}"
                sbatch parabricks_fastq2bam_slurm.sh $fastq $bam $tumor $tumorfq1 $tumorfq2
                normal="${arr[6]}"
                normalfq1="${arr[7]}"
                normalfq2="${arr[8]}"
                sbatch parabricks_fastq2bam_slurm.sh $fastq $bam $normal $normalfq1 $normalfq2
	elif [[ ${#arr[@]} -eq 6 ]]
	then
		fastq="${arr[0]}"
		bam="${arr[1]}"
		sample="${arr[3]}"
		samplefq1="${arr[4]}"
		samplefq2="${arr[5]}"
		sbatch parabricks_fastq2bam_slurm.sh $fastq $bam $sample $samplefq1 $samplefq2
        else
                fastq="${arr[0]}"
                bam="${arr[1]}"
                sample="${arr[2]}"
                samplefq1="${arr[3]}"
                samplefq2="${arr[4]}"
                sbatch parabricks_fastq2bam_slurm.sh $fastq $bam $sample $samplefq1 $samplefq2
        fi
done
