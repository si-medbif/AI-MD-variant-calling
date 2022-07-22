#! /bin/bash

#SBATCH --job-name=strelka-joint-parabricks 
#SBATCH --output=job%j_strelka-joint.log   
#SBATCH --ntasks=1                
#SBATCH --nodes=1          
#SBATCH --nodelist=omega
#SBATCH --export=ALL      
#SBATCH --partition=batch  
#SBATCH --mem=128gb       
#SBATCH --cpus-per-task=64  
#SBATCH --time=4:00:00     

export MODULEPATH=/shared/software/modules:$MODULEPATH
module load parabricks/3.8.0-1-ampere
export REF=/shared/dataset/parabricks_sample/Ref

SAMPLES=$1

LINES=$(cat $SAMPLES)

ALLBAM=""

for line in $LINES
do
	IFS="," read -a arr <<< $line
	bam="${arr[1]}"
	vcf="${arr[2]}"
	normal="${arr[3]}"
	ALLBAM+=" --in-bams ${bam}/${normal}.bam"
done

#echo ${ALLBAM}

pbrun strelka \
	--ref ${REF}/Homo_sapiens_assembly38.fasta \
	--out-prefix ${vcf}/combined \
	--num-threads 64 \
	--bed /shared/example_data/hg38bundle/main_chroms.bed.gz \
	${ALLBAM}

