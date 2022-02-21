# Somatic variant detection

## Scripts
* parabricks_somatic_slurm.sh

  The main script to run the whole analysis from FASTQ to VCF. It requires both a tumor sample and a normal sample. Both sequenced as pair-end reads, using either WGS or WES. The user is required to create a text file with the following tab separated columns:

## Configuartion file

This is a text file with tab separated columns:
1. The name of the script
2. The location of the FASTQ files
3. The location to output the generated BAM files
4. The name for the tumor sample
5. The 1st FASTQ files for the tumor sample
6. The 2nd FASTQ files for the tumor sample
7. The name for the normal sample
8. The 1st FASTQ files for the normal sample
9. The 2nd FASTQ files for the normal sample

## Test data1:
    * Normal : Pair end WGS: 346,586,494 reads
    * Tumor : Pair end WGS: 354,821,067 reads

## Full run times, FASTQ to VCF, using the main pipeline with BWA and the GATK software packages:
    * Data1: 3h 23m                        
    
## Run times, FASTQ to BAM:
    * Tumor1 : 1h 20m                        
    * Normal1: 0h 53m
                        
## Run times, BAM to VCF
    * Mutect2, GPU                    0h 46m
    * Mutect2, CPU                1d  4h 40m
    * SomaticSniper parabricks        4h  4m
    * Manta parabricks            1d  9h 47m
    * Strelka parabricks          1d 21h  2m

## Notes:
  * Mutect2
    * VCF files have to be filtered using filtermutectcall.
    * GATK versions after 4.1.0.0 requires a "Mutect stats table" generated from Mutect2 which is not present here.
    * For GATK versions before 4.0.12.0
      * Add this line to the VCF header: ##INFO=<ID=P_CONTAM,Number=1,Type=Float,Description="Posterior probability for alt allele to be due to contamination">
      * Remove any multiallelic sites.
