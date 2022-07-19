#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.
# TODO: Look into array jobs. (https://help.rc.ufl.edu/doc/SLURM_Job_Arrays)

#SBATCH --job-name=vcfqcbybam-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_vcfqcbybam.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=100gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=12             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=1:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1.ampere
# User-input
BAMDATA=$1
VCFDATA=$2
SAMPLE=$3

pbrun vcfqcbybam \
	--in-bam ${BAMDATA}/${SAMPLE}.bam \
	--in-vcf ${VCFDATA}/${SAMPLE}_hc.filtered.vcf \
	--out-file ${BAMDATA}/${SAMPLE}_pileup.txt \
	--output-dir ${VCFDATA}/${SAMPLE}_vcfqcbybam \
	--min-mapq 30 \
	--num-threads 12 \
	-L chr1 \
	-L chr2

