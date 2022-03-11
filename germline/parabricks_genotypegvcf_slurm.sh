#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.
# TODO: Look into array jobs. (https://help.rc.ufl.edu/doc/SLURM_Job_Arrays)

#SBATCH --job-name=GenotypeGVCF-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_GenotypeGVCF.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=16gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=4             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=1:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.7.0-1.ampere
export REF=/shared/dataset/parabricks_sample/Ref
# User-input
VCFDATA=$1
SAMPLE=$2

pbrun genotypegvcf \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-gvcf ${VCFDATA}/${SAMPLE}_hc.g.vcf.gz \
	--out-vcf ${VCFDATA}/${SAMPLE}_hc.vcf.gz \
	--num-threads 4


#pbrun genotypegvcf \
#	--ref ${REF}/Homo_sapiens_assembly38.fasta \
#	--in-selectvariants-dir ${VCFDATA} \
#	--out-vcf ${VCFDATA}/${SAMPLE}_hc.gvcf.vcf \
#	--num-threads 4