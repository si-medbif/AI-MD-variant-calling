#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=parabricks-strelka    # Job name    # default: script name or sbatch
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --output=strelka_%j.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --time=24:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=256gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=32             # Number of CPUs per task   # default: 1 CPU per task 

# Parabricks software and reference resources
export PB_PATH=/shared/parabrick/parabricks
export PATH=$PB_PATH:$PATH
export PB_HOME=/shared/parabrick/parabricks
export REF=/shared/dataset/parabricks_sample/Ref
# Fastq-files
BAMDATA=$1
VCFDATA=$2
TUMOR=$3
TUMORBAM=$4
NORMAL=$5
NORMALBAM=$6

pbrun strelka_workflow \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--out-prefix ${VCFDATA}/strelka_manta_${TUMOR} \
	--num-threads 32 \
	--in-tumor-bam ${BAMDATA}/${TUMORBAM}.bam  \
	--in-normal-bam ${BAMDATA}/${NORMALBAM}.bam \