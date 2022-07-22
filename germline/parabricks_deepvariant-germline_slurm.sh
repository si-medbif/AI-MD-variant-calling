#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=deepvariant-germline-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_deepvariant-germline.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --gres=gpu:2                  # Number of GPUs requested  # default: none (0) --gres=gpu:3g.20gb:2
#SBATCH --mem=384gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=32             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=2:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1.ampere
#module load parabricks/3.7.0-1.ampere # Limited to the omega node
export REF=/shared/dataset/parabricks_sample/Ref
# User-input
FASTQDATA=$1
BAMDATA=$2
VCFDATA=$3
SAMPLE=$4
FASTQ1=$5
FASTQ2=$6
DATA=$7

if [[ $DATA = "WES" ]]
then
	DATATYPE="--use-wes-model"
else
	DATATYPE=""
fi

pbrun deepvariant_germline \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--knownSites ${REF}/Homo_sapiens_assembly38.known_indels.vcf.gz \
	--in-fq ${FASTQDATA}/${FASTQ1} ${FASTQDATA}/${FASTQ2} "@RG\tID:${SAMPLE}_rg1\tLB:lib1\tPL:bar\tSM:${SAMPLE}\tPU:${SAMPLE}_rg1" \
	--out-recal-file ${BAMDATA}/${SAMPLE}.recal.txt \
	--out-bam ${BAMDATA}/${SAMPLE}.bam  \
	--mode shortread \
	--out-variants ${VCFDATA}/${SAMPLE}.deepvariant.vcf \
	--num-gpus 2 \
	${DATATYPE}


# Options likely to be interesting to change
#--mode [shortread, pacbio, ont]
#--variant-caller [VERY_SENSITIVE_CALLER, VCF_CANDIDATE_IMPORTER]
