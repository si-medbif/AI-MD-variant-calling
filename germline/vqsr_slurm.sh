#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=vqsr    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_vqsr.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=16gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=24             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=2:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export REF=/shared/dataset/parabricks_sample/Ref
export BUNDLE=/shared/example_data/hg38bundle
# User-input
VCFFOLDER=$1
SAMPLE=$2

singularity run \
	--bind ${VCFFOLDER}:/vcf,${BUNDLE}:/bundle \
	/shared/example_data/singularity/gatk.4.2.5.0.sif \
	gatk --java-options "-Xmx16g" VariantRecalibrator \
	-V /vcf/${SAMPLE}.hc.vcf \
	-O /vcf/${SAMPLE}.recal \
	--tranches-file /vcf/${SAMPLE}.tranches \
	--resource:omni,known=false,training=true,truth=true,prior=12.0 /bundle/1000G_omni2.5.hg38.vcf.gz \
	-an QD -an MQ -an MQRankSum -an ReadPosRankSum \
	--mode BOTH

singularity run \
	--bind ${VCFFOLDER}:/vcf \
	/shared/example_data/singularity/gatk.4.2.5.0.sif \
	gatk --java-options "-Xmx16g" ApplyVQSR \
	-V /vcf/${SAMPLE}.hc.vcf \
	--recal-file /vcf/${SAMPLE}.recal \
	--tranches-file /vcf/${SAMPLE}.tranches \
	-O /vcf/${SAMPLE}.hc.vqsr.vcf \
	--mode BOTH

