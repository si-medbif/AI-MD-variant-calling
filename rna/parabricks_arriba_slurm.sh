#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=arriba-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_arriba.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --gres=gpu:4                  # Number of GPUs requested  # default: none (0) --gres=gpu:3g.20gb:2
#SBATCH --mem=384gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=32             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=8:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.7.0-1.ampere
export REF=/shared/dataset/parabricks_sample/Ref
export STAR=/shared/example_data/star_ref/GRCh38_101
export ENSEMBL=/shared/example_data/ensembl
# User-input
FASTQDATA=$1
BAMDATA=$2
VCFDATA=$3
SAMPLE=$4
FASTQ1=$5
FASTQ2=$6


pbrun arriba \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-bam ${BAMDATA}/${SAMPLE}.bam  \
	--in-gene-annotation ${ENSEMBL}/Homo_sapiens.GRCh38.105.gtf.gz \
	--out-fusions-file ${VCFDATA}/${SAMPLE}_passingFusions.tsv \
	--out-filtered-fusions-file  ${VCFDATA}/${SAMPLE}_discardedFusions.tsv
	--genome-lib-dir ${STAR} \
	--num-gpus 4 \
	--num-cpu-threads 12 \
	--num-threads 6 \
