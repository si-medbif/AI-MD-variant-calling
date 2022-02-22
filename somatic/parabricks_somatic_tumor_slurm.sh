#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=somatic-parabricks    # Job name    # default: script name or sbatch
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --output=job%j_somatic.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --gres=gpu:4                  # Number of GPUs requested  # default: none (0) --gres=gpu:3g.20gb:2
#SBATCH --time=8:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 
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
# User-input
FASTQDATA=$1
BAMDATA=$2
VCFDATA=$3
TUMOR=$4
TUMOR1=$5
TUMOR2=$6


pbrun somatic \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--knownSites ${REF}/Homo_sapiens_assembly38.known_indels.vcf.gz \
	--num-gpus=4 \
	--in-tumor-fq ${FASTQDATA}/${TUMOR1} ${FASTQDATA}/${TUMOR2} "@RG\tID:${TUMOR}_rg1\tLB:lib1\tPL:bar\tSM:${TUMOR}\tPU:${TUMOR}_rg1" \
	--out-tumor-bam ${BAMDATA}/${TUMOR}.bam  \
	--out-tumor-recal-file ${BAMDATA}/${TUMOR}.recal.txt \
	--out-vcf  ${VCFDATA}/${TUMOR}_m2.vcf

#./filter_m2_singularity.sh ${VCFDATA} ${TUMOR}
