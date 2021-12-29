# hpc-pipelines

* Somatic variant detection

Test data
  Normal:  Pair end WGS: 702,863,004 reads
  Tumor:   Pair end WGS: 423,930,673 reads

Run times:
  Tumor
  Fastq -> BAM: 2 hour 11 minutes  1 second
                        3 minutes 10 seconds
                       10 minutes 52 seconds
  Normal
  Fastq -> BAM: 1 hour 44 minutes  9 seconds
                        4 minutes  0 seconds
                       17 minutes 26 seconds

  Mutect2 (Note Parabricks version does not currently filter the somatic calls):
  BAM -> VCF:   3 hours 25 minutes 59 seconds
    VCF files have to be filtered using filtermutectcall.
    GATK versions after 4.1.0.0 requires a "Mutect stats table" generated from Mutect2 which is not present here.
    For GATK versions before 4.0.12.0:
      Add this line to the VCF header: 
        ##INFO=<ID=P_CONTAM,Number=1,Type=Float,Description="Posterior probability for alt allele to be due to contamination">
      Remove any multiallelic sites.


  SomaticSniper:
  BAM -> VCF:   4 hours  4 minutes 45 seconds

  Manta/Strelka combined pipeline:
  BAM -> VCF: Manta   1 day  9 hours 47 minutes 28 seconds
              Strelka 1 day 21 hours  2 minutes 30 seconds
