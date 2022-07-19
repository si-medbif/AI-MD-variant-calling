#!/bin/bash

# For the complete information about SBATCH:
# https://slurm.schedmd.com/sbatch.html.

#SBATCH --job-name=trios-parabricks    # Job name    # default: script name or sbatch
#SBATCH --output=job%j_trios.log           # Output file    # default: slurm-<jobid>.out
#SBATCH --ntasks=1                    # Number of tasks    # default: 1 task per node
#SBATCH --nodes=1              # Req min-max of nodes      # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega
#SBATCH --export=ALL        # Pass the env var
#SBATCH --partition=batch       # Req specific partition    # default: batch
#SBATCH --mem=128gb                    # Memory size requested   # default: 4gb
#SBATCH --cpus-per-task=12             # Number of CPUs per task   # default: 1 CPU per task 
#SBATCH --time=8:00:00               # Time limit hrs:min:sec   # default: 01:00:00 (+1 hours of extra overtime limit) 

# Parabricks software and reference resources
export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1.ampere
export REF=/shared/dataset/parabricks_sample/Ref

SAMPLES=$1

LINES=$(cat $SAMPLES)

ALLVCF=""

count=0

for line in $LINES
do
	IFS="," read -a arr <<< $line
	vcf="${arr[2]}"
	normal="${arr[3]}"
	ALLVCF+=" --in-gvcf ${vcf}/${normal}.hc.g.vcf.gz"
	((count+=1))
done

if [[ count -gt 3 ]]
then
	echo "ERROR: Found ${count} samples, but this tool only accepts at most 3 samples."
	exit 1
fi

pbrun triocombinegvcf \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--out-variants ${vcf}/combined.hc.g.vcf \
	${ALLVCF}

pbrun genotypegvcf \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--in-gvcf ${vcf}/combined.hc.g.vcf \
	--out-vcf ${vcf}/combined.hc.vcf \
	--num-threads 4
