#! /bin/bash

#SBATCH --job-name=parabricks-harald
#SBATCH --ntasks=8
#SBATCH --nodes=1

singularity run \
	--bind /home/harald.gro/parabricks_sample/Ref/:/ref,/home/harald.gro/testing:/data \
	../data/gatk4-0-12-0.sif \
	gatk --java-options "-Xmx8g" FilterMutectCalls \
	-R /ref/Homo_sapiens_assembly38.fasta \
	-V /data/BB-T0006-DNA_mutect2.vcf \
	-O /data/BB-T0006-DNA_mutect2_filter.vcf
