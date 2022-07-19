#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=muse-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_muse.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=256gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=32             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=8:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1.ampere
export REF=/shared/dataset/parabricks_sample/Ref
# User-input
BAMDATA=$1
VCFDATA=$2
TUMOR=$3
NORMAL=$4
DATATYPE=$5

pbrun muse \
	--mode call \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-tumor-bam ${BAMDATA}/${TUMOR}.bam \
	--in-normal-bam ${BAMDATA}/${NORMAL}.bam \
	--out-file ${VCFDATA}/${TUMOR} \
	--num-threads 32

pbrun muse \
	--mode sump \
	--in-callfile ${VCFDATA}/${TUMOR}.MuSE.txt \
	--out-vcf ${VCFDATA}/${TUMOR}_muse_sump_results.vcf \
	--datatype ${DATATYPE} \
	--in-dbsnp /shared/example_data/dbsnp/dbsnp_146.hg38.vcf.gz \
	--num-threads 32

