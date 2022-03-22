#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.
# TODO: Look into array jobs. (https://help.rc.ufl.edu/doc/SLURM_Job_Arrays)

#SBATCH --job-name=snpswift-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_snpswift.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=16gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=8             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=1:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
export ANNOREF=/shared/example_data/pb_annot
module load parabricks/3.7.0-1.ampere
# User-input
VCFDATA=$1
SAMPLE=$2

pbrun snpswift \
	--input-vcf ${VCFDATA}/${SAMPLE}_hc.filtered.vcf \
	--anno-vcf 1000Genomes:${ANNOREF}/ALL.wgs.shapeit2_integrated_v1a.GRCh38.20181129.sites.vcf.gz \
	--anno-vcf gnomad_v2.1.1:${ANNOREF}/gnomad.exomes.r2.1.1.sites.liftover_grch38.vcf.bgz \
	--anno-vcf ClinVar:${ANNOREF}/clinvar.vcf.gz \
	--ensembl ${ANNOREF}/Homo_sapiens.GRCh38.105.chr.gtf  \
	--output-vcf ${VCFDATA}/${SAMPLE}_hc.filtered.annotated.vcf \
	--num-threads 8

