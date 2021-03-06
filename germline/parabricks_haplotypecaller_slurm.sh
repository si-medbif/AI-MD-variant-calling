#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.
# TODO: Look into array jobs. (https://help.rc.ufl.edu/doc/SLURM_Job_Arrays)

#SBATCH --job-name=germline-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_germline.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --gres=gpu:2                  # Number of GPUs requested  # default: none (0) --gres=gpu:3g.20gb:2
#SBATCH --mem=100gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=24             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=8:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.7.0-1.ampere
export REF=/shared/dataset/parabricks_sample/Ref
# User-input
BAMDATA=$1
VCFDATA=$2
SAMPLE=$3


pbrun haplotypecaller \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-bam ${BAMDATA}/${SAMPLE}.bam  \
	--in-recal-file ${BAMDATA}/${SAMPLE}.recal.txt \
	--num-gpus 2 \
	--out-variants ${VCFDATA}/${SAMPLE}.hc.vcf \
