#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=cnvkit-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_cnvkit.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=256gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=16             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=2:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1.ampere
export REF=/shared/dataset/parabricks_sample/Ref
export REF_DB=/shared/example_data/ensembl
export REF_EXONS=/shared/example_data/bed
# User-input
BAMDATA=$1
VCFDATA=$2
SAMPLE=$3
operation=$4
PRECNN=""

if [[ $operation = "batch" ]]
then
pbrun cnvkit \
	--sub-command batch \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-bam ${BAMDATA}/${SAMPLE}.bam \
	--batch-output-dir ${VCFDATA}/${SAMPLE}_cnvkit-batch \
	--batch-annotate ${REF_DB}/Homo_sapiens.GRCh38.105.chr.gtf \
	--generate-vcf \
	${PRECNN}
elif [[ $operation = "autobin" ]]
then
pbrun cnvkit \
	--sub-command autobin \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-bam ${BAMDATA}/${SAMPLE}.bam \
	--target-output-bed ${VCFDATA}/${SAMPLE}_target.bed \
	--antitarget-output-bed ${VCFDATA}/${SAMPLE}_antitarget.bed \
	--autobin-access ${REF_EXONS}/S31285117_Regions.bed \
	--autobin-targets ${REF_EXONS}/S31285117_Regions.bed \
	--autobin-annotate ${REF_DB}/Homo_sapiens.GRCh38.105.chr.gtf
elif [[ $operation = "coverage" ]]
then
pbrun cnvkit \
	--sub-command coverage \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-bam ${BAMDATA}/${SAMPLE}.bam \
	--coverage-output ${VCFDATA}/${SAMPLE}.coverage.txt \
	--coverage-interval ${REF_EXONS}/S31285117_Regions.bed
else
	echo "Unknown option"
fi
