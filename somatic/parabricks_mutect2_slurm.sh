#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=mutect2-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_mutectcaller.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --gres=gpu:2                  # Number of GPUs requested  # default: none (0)
#SBATCH --mem=128gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=24             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=3:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.7.0-1.ampere
export REF=/shared/dataset/parabricks_sample/Ref
# User-input
BAMDATA=$1
VCFDATA=$2
TUMOR=$3
NORMAL=$4

pbrun mutectcaller \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-tumor-bam ${BAMDATA}/${TUMOR}.bam  \
	--num-gpus 2 \
	--tumor-name ${TUMOR} \
	--in-tumor-recal-file ${BAMDATA}/${TUMOR}.recal.txt \
	--in-normal-bam ${BAMDATA}/${NORMAL}.bam \
	--normal-name ${NORMAL} \
	--in-normal-recal-file ${BAMDATA}/${NORMAL}.recal.txt \
	--out-vcf  ${VCFDATA}/${TUMOR}_m2.vcf

filter_m2_singularity.sh ${VCFDATA} ${TUMOR}
