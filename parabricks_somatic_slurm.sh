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

pbrun somatic \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--knownSites ${REF}/Homo_sapiens_assembly38.known_indels.vcf.gz \
	--gpu-devices 0,1 --num-gpus=2 \
	--in-tumor-fq ${DATA}/R19008208LD01-BB-T0006-DNA_combined_R1.fastq.gz ${DATA}/R19008208LD01-BB-T0006-DNA_combined_R2.fastq.gz "@RG\tID:sm_tumor_rg1\tLB:lib1\tPL:bar\tSM:sm_tumor\tPU:sm_tumor_rg1" \
	--out-tumor-bam ${DATA}/BB-T0006-DNA.bam  \
	--out-tumor-recal-file ${DATA}/BB-T0006-DNA.recal.txt \
	--in-normal-fq ${DATA}/R19037118LD01-BB-B0006-DNA_combined_R1.fastq.gz ${DATA}/R19037118LD01-BB-B0006-DNA_combined_R2.fastq.gz "@RG\tID:sm_normal_rg1\tLB:lib1\tPL:bar\tSM:sm_normal\tPU:sm_normal_rg1" \
	--out-normal-bam ${DATA}/BB-B0006-DNA.bam \
	--out-normal-recal-file ${DATA}/BB-B0006-DNA.recal.txt \
	--out-vcf  BB-T0006-DNA_mutect2.vcf

