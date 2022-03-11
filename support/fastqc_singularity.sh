#! /bin/bash

#SBATCH --job-name=fastqc
#SBATCH --ntasks=1
#SBATCH --output=job%j_fastqc.log
#SBATCH --nodes=1
#SBATCH --nodelist=omega
#SBATCH --mem=8gb
#SBATCH --cpus-per-task=2

# Parabricks software and reference resources
export REF=/shared/dataset/parabricks_sample/Ref

FASTQFOLDER=$1
SAMPLEFQ1=$2
SAMPLEFQ2=$3

singularity run \
	--bind ${FASTQFOLDER}:/fastq \
	/shared/example_data/singularity/fastqc.sif \
	fastqc \
	-o /fastq \
	-t 2 \
	/fastq/${SAMPLEFQ1} \
	/fastq/${SAMPLEFQ2}
