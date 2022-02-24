#! /bin/bash

#SBATCH --job-name=FilterMutectCalls
#SBATCH --ntasks=1
#SBATCH --output=filtermutectcalls_%j.log
#SBATCH --nodes=1
#SBATCH --nodelist=omega
#SBATCH --mem=8gb
#SBATCH --cpus-per-task=1

# Parabricks software and reference resources
export PB_PATH=/shared/parabrick/parabricks
export PATH=$PB_PATH:$PATH
export PB_HOME=/shared/parabrick/parabricks
export REF=/shared/dataset/parabricks_sample/Ref

VCFFOLDER=$1
TUMOR=$2

singularity run \
	--bind ${REF}:/ref,${VCFFOLDER}:/data \
	/shared/example_data/singularity/gatk.4.0.12.0.sif \
	gatk --java-options "-Xmx8g" FilterMutectCalls \
	-R /ref/Homo_sapiens_assembly38.fasta \
	--stats /data/${TUMOR}_Mutect2FilteringStats.tsv \
	-V /data/${TUMOR}_m2.vcf \
	-O /data/${TUMOR}_m2_filter.vcf
