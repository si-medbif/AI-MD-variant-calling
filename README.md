# HPC-pipelines

## Somatic variant detection

### Test data:
    * Normal:  Pair end WGS: 702,863,004 reads
    * Tumor :  Pair end WGS: 423,930,673 reads

### Run times, FASTQ to BAM:
    * Tumor : 2 hour 25 minutes  3 second                        
    * Normal: 1 hour 65 minutes 35 seconds
                        
### Run times, BAM to VCF
    * Mutect2:             3 hours 25 minutes 59 seconds
    * SomaticSniper        4 hours  4 minutes 45 seconds
    * Manta         1 day  9 hours 47 minutes 28 seconds
    * Strelka       1 day 21 hours  2 minutes 30 seconds

#### Notes:
  * Mutect2
    * VCF files have to be filtered using filtermutectcall.
    * GATK versions after 4.1.0.0 requires a "Mutect stats table" generated from Mutect2 which is not present here.
    * For GATK versions before 4.0.12.0
      * Add this line to the VCF header: ##INFO=<ID=P_CONTAM,Number=1,Type=Float,Description="Posterior probability for alt allele to be due to contamination">
      * Remove any multiallelic sites.
