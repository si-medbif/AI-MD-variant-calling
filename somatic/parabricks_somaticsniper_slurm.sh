#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=parabricks-harald    # Job name    # default: script name or sbatch
#SBATCH --ntasks=4                    # Number of tasks    # default: 1 task per node
#SBATCH --output=my_job%j.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --gres=gpu:2                  # Number of GPUs requested  # default: none (0)
#SBATCH --time=3:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=128gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=2             # Number of CPUs per task   # default: 1 CPU per task 

# Parabricks software and reference resources
export PB_PATH=/shared/parabrick/parabricks
export PATH=$PB_PATH:$PATH
export PB_HOME=/shared/parabrick/parabricks
export REF=/shared/dataset/parabricks_sample/Ref
# Fastq-files
export DATA=/home/harald.gro/data

pbrun somaticsniper \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--out-file somaticsniper_0006.vcf \
	--gpu-devices 0,1 --num-gpus=2 \
	--in-tumor-bam ${DATA}/BB-T0006-DNA.bam  \
	--in-normal-bam ${DATA}/BB-B0006-DNA.bam \
	--out-format vcf

