#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=fastq2bam-parabricks    # Job name    # default: script name or sbatch
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --output=job%j_fq2bam.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --gres=gpu:2                  # Number of GPUs requested  # default: none (0) --gres=gpu:3g.20gb:2
#SBATCH --time=8:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=256gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=24             # Number of CPUs per task   # default: 1 CPU per task 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.7.0-1.ampere

export REF=/shared/dataset/parabricks_sample/Ref
# User-input
FASTQDATA=$1
BAMDATA=$2
TUMOR=$3
TUMOR1=$4
TUMOR2=$5

pbrun --version

pbrun fq2bam \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--knownSites ${REF}/Homo_sapiens_assembly38.known_indels.vcf.gz \
	--num-gpus=2 \
	--in-fq ${FASTQDATA}/${TUMOR1} ${FASTQDATA}/${TUMOR2} "@RG\tID:${TUMOR}_rg1\tLB:lib1\tPL:bar\tSM:${TUMOR}\tPU:${TUMOR}_rg1" \
	--out-bam ${BAMDATA}/${TUMOR}.bam  \
	--out-recal-file ${BAMDATA}/${TUMOR}.recal.txt \

