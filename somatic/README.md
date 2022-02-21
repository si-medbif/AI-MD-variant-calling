# Somatic variant detection

## Complete pipeline from FASTQ to VCF:
    run_full_somatic.sh config1.txt

  The main script to run the whole analysis from FASTQ to VCF. It requires both a tumor sample and a normal sample. Both sequenced as pair-end reads, using either WGS or WES. The config-file lists information for one sample per line with a format as described below. In this way several samples can be queued up for analysis.

### Configuration file

This is a text file with comma separated columns:
1. The location of the FASTQ files
2. The location to output the generated BAM files
3. The location to output the generated VCF files
4. The name for the tumor sample
5. The 1st FASTQ file for the tumor sample
6. The 2nd FASTQ file for the tumor sample
7. The name for the normal sample
8. The 1st FASTQ file for the normal sample
9. The 2nd FASTQ file for the normal sample

## Steps
Each step in the pipeline can also be run individually. The columns in the configuration file will be different, as shown.

## Read alignment and BAM processing:
    run_fastq2bam.sh config2.txt

### Configuration file 2
1. The location of the FASTQ files
2. The location to output the generated BAM files
3. The name for the sample
4. The 1st FASTQ file for the sample
5. The 2nd FASTQ file for the sample

## Only somatic variant calling
    * run_mutect2.sh config3.txt

### Configuration file 3
1. The location to output the generated BAM files
2. The location to output the generated VCF files
3. The name for the tumor sample
4. The tumor BAM file
5. The name for the normal sample
6. The normal bam file

## Notes:
  * Mutect2
    * VCF files have to be filtered using filtermutectcall.
    * GATK versions after 4.1.0.0 requires a "Mutect stats table" generated from Mutect2 which is not present here.


# Example run-times

## Test data1:
    * Normal : Pair end WGS: 346,586,494 reads
    * Tumor : Pair end WGS: 354,821,067 reads

## Full run times, FASTQ to VCF, using the main pipeline with BWA and the GATK software packages:
    * Tumor1 & Normal1: 3h 23m                        
    
