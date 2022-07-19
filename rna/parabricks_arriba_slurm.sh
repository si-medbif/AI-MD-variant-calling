#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=arriba-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_arriba.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=384gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=32             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=2:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1.ampere
export REF=/shared/dataset/parabricks_sample/Ref
export STAR=/shared/example_data/star_ref/GRCh38_101
export ENSEMBL=/shared/example_data/ensembl
export ARRIBA=/shared/example_data/arriba_database
# User-input
BAMDATA=$1
VCFDATA=$2
SAMPLE=$3

# pbrun arriba -h

pbrun arriba \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-bam ${BAMDATA}/${SAMPLE}.bam  \
	--in-gene-annotation ${ENSEMBL}/Homo_sapiens.GRCh38.105.chr.gtf \
	--out-fusions-file ${VCFDATA}/${SAMPLE}_passingFusions.tsv \
	--out-filtered-fusions-file  ${VCFDATA}/${SAMPLE}_discardedFusions.tsv \
	--in-blacklist-file ${ARRIBA}/blacklist_hg38_GRCh38_v2.2.1.tsv.gz \
	--in-known-fusions-file ${ARRIBA}/known_fusions_hg38_GRCh38_v2.2.1.tsv.gz \
	--in-protein-file ${ARRIBA}/protein_domains_hg38_GRCh38_v2.2.1.gff3
