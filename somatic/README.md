# Somatic variant detection

## Options for running the parabricks scripts

The following scripts are ready for use depending on which analysis is required

### Full pipeline
| Task | Main script | Helper script |
| --- | --- | --- |
| Full | [parabricks_somatic_slurm.sh](./parabricks_somatic_slurm.sh) | [run_full_somatic.sh](./run_full_somatic.sh) |
| Full Tumor-only | [parabricks_somatic_tumor_slurm.sh](./parabricks_somatic_tumor_slurm.sh) | [run_full_somatic_tumor.sh](./run_full_somatic_tumor.sh) |

**Use Full version** if you start with fastq

### Just variant calling
| Task | Main script | Helper script |
| --- | --- | --- |
| Mutect2 | [parabricks_mutect2_slurm.sh](./parabricks_mutect2_slurm.sh) | [run_mutect2.sh](./run_mutect2.sh) |
| SomaticSniper | [parabricks_somaticsniper_slurm.sh](./parabricks_somaticsniper_slurm.sh) | [run_somaticsniper.sh](./run_somaticsniper.sh) |
| LoFreq | [parabricks_lofreq_slurm.sh](./parabricks_lofreq_slurm.sh) | [run_lofreq.sh](./run_lofreq.sh) |
| Strelka & Manta | [parabricks_strelkamanta_slurm.sh](./parabricks_strelkamanta_slurm.sh) | [run_strelkamanta.sh](./run_sv_strelkamanta.sh) |

**Use Mutect2 version** if you already have BAM

The main scripts contain reasonable default settings for the [slurm](https://github.com/si-medbif/hpc-pipelines/blob/main/documents/slurm.md) parameters, as well as the Parabricks command line. Information about the input files and folder locations have to be either provided on the command line or edited into the script file.

An alternative way of running the main scripts is by using the helper scripts. The difference is that here the input is a configuration file with all the details about the samples to be run. The configuration file can also contain information about several samples, each line being a different sample.

## Full pipeline from FASTQ to VCF:
```
run_full_somatic.sh config1.txt        # Matched Tumor-Normal
run_full_somatic_tumor.sh config1.txt  # Tumor only
```

  The main scripts to run the whole analysis from FASTQ to VCF. It can be run both with a set of matched tumor-normal FASTQ files, or with only a tumor FASTQ file. The config-file lists information for one sample per line with a format as described below. In this way several samples can be queued up for analysis.

The main somatic pipeline does not (yet) filter the variant calls, this step has been added using a singluarity image of GATK to run the FilterMutectCalls process.

### Configuration1 file

This is a text file with comma separated columns:
```
1. The location of the FASTQ files
2. The location to output the generated BAM files
3. The location to output the generated VCF files
4. The name for the tumor sample
5. The 1st FASTQ file for the tumor sample
6. The 2nd FASTQ file for the tumor sample
7. The name for the normal sample
8. The 1st FASTQ file for the normal sample
9. The 2nd FASTQ file for the normal sample
```
- [Example config file 1](https://github.com/si-medbif/hpc-pipelines/blob/main/example/config1_WES_example.txt)

## Variant calling
After generating the tumor and normal BAM files, there are several somatic variant callers available

## Somatic variant calling
```
run_mutect2.sh config2.txt
run_somaticsniper.sh config2.txt
run_lofreq.sh config2.txt
```

## Structural variant calling

```
run_sv_strelkamanta.sh config2.txt
```

### Configuration2 file:

This is a text file with comma separated columns:
```
1. The location to output the generated BAM files
2. The location to output the generated VCF files
3. The name for the tumor sample
4. The tumor BAM file
5. The name for the normal sample
6. The normal bam file
```
- [Example config file 2](https://github.com/si-medbif/hpc-pipelines/blob/main/example/config2_WES_example.txt)

## Notes:
  * Mutect2
    * VCF files have to be filtered using the FilterMutectCall from GATK [filter_m2_singularity.sh](https://github.com/si-medbif/hpc-pipelines/blob/main/somatic/filter_m2_singularity.sh).


# Example run-times

## Test data:

The runtime has been tested on a publically available [WES dataset](https://github.com/si-medbif/hpc-pipelines/example/README.md) and on a private WGS dataset. Both datasets contained a tumor and a matched normal sample.

## Full run times, FASTQ to VCF, using the main pipeline with BWA and the GATK software packages:
    * WES:                 19m
    * WGS:              1h 32m (filtered VCF)
    * WGS, tumor only:     45m (VCF) + 44m (filtered VCF) 
