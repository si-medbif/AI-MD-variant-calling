#! /bin/bash

#SBATCH --job-name=FilterMutectCalls
#SBATCH --ntasks=8
#SBATCH --nodes=1

REFERENCE=$1
VCFFOLDER=$2
TUMOR=$3
SING=$4

singularity run \
	--bind ${REFERENCE}:/ref,${VCFFOLDER}:/data \
	${SING}/gatk4-0-12-0.sif \
	gatk --java-options "-Xmx8g" FilterMutectCalls \
	-R /ref/Homo_sapiens_assembly38.fasta \
	-V /data/${TUMOR}_mutect2.vcf \
	-O /data/${TUMOR}_mutect2_filter.vcf
