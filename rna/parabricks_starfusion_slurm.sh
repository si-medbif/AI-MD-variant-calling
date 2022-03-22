#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=starfusion-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_starfusion.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=64gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=4             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=2:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.7.0-1.ampere
export REF=/shared/dataset/parabricks_sample/Ref
export STAR=/shared/example_data/star_ref/GRCh38.v39_2.7.2a
export ENSEMBL=/shared/example_data/ensembl
export ARRIBA=/shared/example_data/arriba_database
# User-input
BAMDATA=$1
VCFDATA=$2
SAMPLE=$3

pbrun starfusion \
	--chimeric-junction ${BAMDATA}/${SAMPLE}/SJ.out.tab \
	--genome-lib-dir ${STAR} \
	--output-dir ${VCFDATA}/${SAMPLE}_starfusion \
	--num-threads 4 \
	--out-prefix ${SAMPLE}
