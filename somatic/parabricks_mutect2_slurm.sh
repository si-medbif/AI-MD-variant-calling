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
# User-input
BAMDATA=$1
VCFDATA=$2
TUMOR=$3
TUMORBAM=$4
NORMAL=$5
NORMALBAM=$6

pbrun mutectcaller \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-tumor-bam ${BAMDATA}/${TUMORBAM}.bam  \
	--num-gpus 2 \
	--tumor-name ${TUMOR} \
	--in-tumor-recal-file ${BAMDATA}/${TUMORBAM}.recal.txt \
	--in-normal-bam ${BAMDATA}/${NORMALBAM}.bam \
	--normal-name ${NORMAL} \
	--in-normal-recal-file ${BAMDATA}/${NORMALBAM}.recal.txt \
	--out-vcf  ${VCFDATA}/${TUMOR}_m2.vcf

