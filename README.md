# HPC-pipelines

## Somatic variant detection

### Test data1:
    * Normal : Pair end WGS: 346,586,494 reads
    * Tumor : Pair end WGS: 354,821,067 reads

### Full run times, FASTQ to VCF:
    * Data1: 3h 23m                        
    
### Run times, FASTQ to BAM:
    * Tumor1 : 1h 20m                        
    * Normal1: 0h 53m
                        
### Run times, BAM to VCF
    * Mutect2 parabricks              0h 46m
    * Mutect2                     1d  4h 40m
    * SomaticSniper parabricks        4h  4m
    * Manta parabricks            1d  9h 47m
    * Strelka parabricks          1d 21h  2m

#### Notes:
  * Mutect2
    * VCF files have to be filtered using filtermutectcall.
    * GATK versions after 4.1.0.0 requires a "Mutect stats table" generated from Mutect2 which is not present here.
    * For GATK versions before 4.0.12.0
      * Add this line to the VCF header: ##INFO=<ID=P_CONTAM,Number=1,Type=Float,Description="Posterior probability for alt allele to be due to contamination">
      * Remove any multiallelic sites.
