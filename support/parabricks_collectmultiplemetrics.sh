#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=collectmultiplemetrics-parabricks    # Job name    # default: script name or sbatch
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --output=job%j_collectmultiplemetrics.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --time=3:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 
#SBATCH --gres=gpu:1
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=128gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=11             # Number of CPUs per task   # default: 1 CPU per task 

# Parabricks software and reference resources
export PB_PATH=/shared/parabrick/parabricks
export PATH=$PB_PATH:$PATH
export PB_HOME=/shared/parabrick/parabricks
export REF=/shared/dataset/parabricks_sample/Ref
# User-input
BAMDATA=$1
BAMSAMPLE=$2


pbrun collectmultiplemetrics \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--bam ${BAMDATA}/${BAMSAMPLE}.bam  \
	--out-qc-metrics-dir ${BAMDATA}/${BAMSAMPLE}.output-qc \
	--gpu-devices 0 \
	--gen-all-metrics 

