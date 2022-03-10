#! /bin/bash

#SBATCH --job-name=FilterMutectCalls
#SBATCH --ntasks=1
#SBATCH --output=job%j_filtermutectcalls.log
#SBATCH --nodes=1
#SBATCH --nodelist=omega
#SBATCH --mem=8gb
#SBATCH --cpus-per-task=1

# Parabricks software and reference resources
export REF=/shared/dataset/parabricks_sample/Ref

VCFFOLDER=/home/harald.gro/germline_wgs/vcf
TUMOR=BB-B0863

singularity run \
	--bind ${REF}:/ref,${VCFFOLDER}:/data \
	/shared/example_data/singularity/gatk.4.2.5.0.sif \
	gatk --java-options "-Xmx8g" ApplyVQSR \
	-V /data/${TUMOR}_hc.vcf \
	-O /data/${TUMOR}_hc.filtered.vcf \
	--recal-file /data/${TUMOR}.recal \
	--tranches-file /data/${TUMOR}.tranches \
	--mode BOTH
