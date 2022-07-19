#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=bam2fastq-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_bam2fq.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=128gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=6             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=3:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1.ampere

export REF=/shared/dataset/parabricks_sample/Ref
# User-input
FASTQDATA=$1
BAMDATA=$2
FASTQSAMPLE=$3
BAMSAMPLE=$4


pbrun bam2fq \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--num-threads 6 \
	--out-fq1 ${FASTQDATA}/${FASTQSAMPLE}_R1.fastq.gz \
	--out-fq2 ${FASTQDATA}/${FASTQSAMPLE}_R2.fastq.gz \
	--in-bam ${BAMDATA}/${BAMSAMPLE}.bam  \

