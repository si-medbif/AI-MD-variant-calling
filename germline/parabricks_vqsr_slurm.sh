#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.
# TODO: Look into array jobs. (https://help.rc.ufl.edu/doc/SLURM_Job_Arrays)

#SBATCH --job-name=vqsr-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_vqsr.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=128gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=8             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=8:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
#module load parabricks/3.7.0-1.ampere
module load parabricks/3.6.1-1-ampere
export REF=/shared/dataset/parabricks_sample/Ref
export BUNDLE=/shared/example_data/hg38bundle
# User-input
VCFDATA=$1
SAMPLE=$2


pbrun vqsr \
	--in-vcf ${VCFDATA}/${SAMPLE}_hc.vcf \
	--out-vcf ${VCFDATA}/${SAMPLE}_hc.vqsr.vcf \
	--out-recal ${VCFDATA}/${SAMPLE}.recal \
	--out-tranches ${VCFDATA}/${SAMPLE}.tranches \
	--resource omni,known=false,training=true,truth=true,prior=12.0:${BUNDLE}/1000G_omni2.5.hg38.vcf \
	--annotation QD \
	--annotation MQ \
	--annotation MQRankSum \
	--annotation ReadPosRankSum 

#pbrun vqsr \
#	--in-vcf ${VCFDATA}/${SAMPLE}_hc.vcf \
#	--out-vcf ${VCFDATA}/${SAMPLE}_hc.vqsr.vcf \
#	--out-recal ${VCFDATA}/${SAMPLE}.recal \
#	--out-tranches ${VCFDATA}/${SAMPLE}.tranches \
#	--resource omni,known=false,training=true,truth=false,prior=12.0:${BUNDLE}/1000G_omni2.5.hg38.vcf \
#	--resource 1000G,known=false,training=true,truth=false,prior=10.0:${BUNDLE}/1000G_phase1.snps.high_confidence.hg38.vcf \
#	--resource dbsnp,known=false,training=true,truth=true,prior=7.0:${BUNDLE}/dbsnp_146.hg38.vcf \
#	--resource hapmap,known=false,training=true,truth=false,prior=15.0:${BUNDLE}/hapmap_3.3.hg38.vcf \
#	--annotation QD \
#	--annotation MQ \
#	--annotation MQRankSum \
#	--annotation ReadPosRankSum 

