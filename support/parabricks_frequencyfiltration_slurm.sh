#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=freq-filter-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_freq-filter.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=16gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=4             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=1:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1.ampere
# User-input
INVCF=$1
let a=${#INVCF}-4
first=${INVCF:0:$a}
second=${INVCF:(-4)}
OUTVCF=$first.freqfilter.vcf

pbrun frequencyfiltration  \
	--in-vcf ${INVCF} \
	--out-vcf ${OUTVCF} \
	--and-expression "1000Genomes_AF < 0.05" \
	--and-expression "gnomad_v2.1.1_AF < 0.05"
