#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.
# TODO: Look into array jobs. (https://help.rc.ufl.edu/doc/SLURM_Job_Arrays)

#SBATCH --job-name=vbvm-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_vbvm.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --gres=gpu:2
#SBATCH --mem=100gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=24             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=1:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1.ampere
export REF=/shared/dataset/parabricks_sample/Ref
export BUNDLE=/shared/example_data/hg38bundle
# User-input
VCFDATA=$1
SAMPLE=$2

#singularity run ~/singularity/tabix.1.9.sif bgzip -c BB-B0863_hc.vcf > BB-B0863_hc.vcf.gz
#singularity run ~/singularity/tabix.1.9.sif tabix -fp vcf BB-B0863_hc.vcf.gz
#singularity run ~/singularity/tabix.1.9.sif bgzip -c BB-B0863_deepvariant.vcf > BB-B0863_deepvariant.vcf.gz
#singularity run ~/singularity/tabix.1.9.sif tabix -fp vcf BB-B0863_deepvariant.vcf.gz



pbrun votebasedvcfmerger \
	--in-vcf haplotypecaller:${VCFDATA}/${SAMPLE}.hc.vqsr.vcf.gz \
	--in-vcf strelka:${VCFDATA}/${SAMPLE}.strelka_work/results/variants/variants.vcf.gz \
	--in-vcf deepvariant:${VCFDATA}/${SAMPLE}.deepvariant.vcf.gz \
	--out-dir ${VCFDATA}/${SAMPLE}.vbvm \
	--min-votes 3 \
	--num-gpus 2
