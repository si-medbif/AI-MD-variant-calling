#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=bammetrics-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_bammetrics.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=128gb                    # Memory size requested   # default: 4gb
#SBATCH --time=3:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 
#SBATCH --cpus-per-task=12             # Number of CPUs per task   # default: 1 CPU per task 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1.ampere

export REF=/shared/dataset/parabricks_sample/Ref
# User-input
BAMDATA=$1
BAMSAMPLE=$2


pbrun bammetrics \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--num-threads 12 \
	--bam ${BAMDATA}/${BAMSAMPLE}.bam  \
	--out-metrics-file ${BAMDATA}/${BAMSAMPLE}.metrics.txt

