#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=manta-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_manta.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=128gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=32             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=8:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
#module load parabricks/3.7.0-1.ampere
module load parabricks/3.6.1-1-ampere
export REF=/shared/dataset/parabricks_sample/Ref
# User input
BAMDATA=$1
VCFDATA=$2
TUMOR=$3
NORMAL=$4

pbrun manta \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-tumor-bam ${BAMDATA}/${TUMOR}.bam \
	--in-normal-bam ${BAMDATA}/${NORMAL}.bam \
	--out-prefix ${VCFDATA}/${TUMOR} \
	--num-threads 32

