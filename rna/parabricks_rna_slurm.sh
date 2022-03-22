#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=rna-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_rna.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --gres=gpu:2                  # Number of GPUs requested  # default: none (0) --gres=gpu:3g.20gb:2
#SBATCH --mem=412gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=32             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=8:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

set -x

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.7.0-1.ampere
export pbREF=/shared/dataset/parabricks_sample/Ref
export REF=/shared/example_data/gencode
export STAR=/shared/example_data/star_ref/GRCh38.v39_2.7.2a
# User-input
FASTQDATA=$1
BAMDATA=$2
VCFDATA=$3
SAMPLE=$4
FASTQ1=$5
FASTQ2=$6


pbrun rna_gatk \
	--ref ${REF}/GRCh38.primary_assembly.genome.fa \
	--in-fq ${FASTQDATA}/${FASTQ1} ${FASTQDATA}/${FASTQ2} "@RG\tID:${SAMPLE}_rg1\tLB:lib1\tPL:bar\tSM:${SAMPLE}\tPU:${SAMPLE}_rg1" \
	--knownSites ${pbREF}/Homo_sapiens_assembly38.known_indels.vcf.gz \
	--genome-lib-dir ${STAR} \
	--out-bam ${BAMDATA}/${SAMPLE}.bam  \
	--out-recal-file ${BAMDATA}/${SAMPLE}.recal.txt \
	--num-gpus 2 \
	--num-cpu-threads 12 \
	--num-threads 6 \
	--read-files-command zcat \
	--rna \
	--dont-use-soft-clipped-bases \
	--out-variants ${VCFDATA}/${SAMPLE}_hc.vcf \
	--output-dir ${BAMDATA}/${SAMPLE}
