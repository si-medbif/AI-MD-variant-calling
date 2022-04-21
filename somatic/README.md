# Somatic variant detection

## Full pipeline
| Task | Main script | Helper script |
| --- | --- | --- |
| Full | [parabricks_somatic_slurm.sh](./parabricks_somatic_slurm.sh) | [run_full_somatic.sh](./run_full_somatic.sh) |
| Full Tumor-only | [parabricks_somatic_tumor_slurm.sh](./parabricks_somatic_tumor_slurm.sh) | [run_full_somatic_tumor.sh](./run_full_somatic_tumor.sh) |

**Use Full pipeline** if you start with FASTQ files

```bash
run_full_somatic.sh config1.txt        # Matched Tumor-Normal
run_full_somatic_tumor.sh config1.txt  # Tumor only
```

The helper scripts are a convenient way of running the pipeline. The input is a configuration file with all the details about the samples to be run, see below for details. The configuration file can also contain information about more than one sample.

The main scripts contain reasonable default settings for the [slurm](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/documents/slurm.md) parameters, as well as the Parabricks command line. Information about the input files and folder locations have to be either provided on the command line or edited into the script file.

### Configuration1 file

This is a text file with 9 comma separated columns:
```
1. The folder containing the FASTQ files
2. The folder where the generated BAM files should be stored
3. The folder where the generated VCF files should be stored
4. The name for the tumor sample
5. The 1st FASTQ file for the tumor sample
6. The 2nd FASTQ file for the tumor sample
7. The name for the normal sample
8. The 1st FASTQ file for the normal sample
9. The 2nd FASTQ file for the normal sample
```
- [Example config file 1](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/example/config1_WES_example.txt)

## Individual variant callers
After generating the tumor and normal BAM files, there are several somatic variant callers available

| Task | Main script | Helper script |
| --- | --- | --- |
| Mutect2 | [parabricks_mutect2_slurm.sh](./parabricks_mutect2_slurm.sh) | [run_mutect2.sh](./run_mutect2.sh) |
| SomaticSniper | [parabricks_somaticsniper_slurm.sh](./parabricks_somaticsniper_slurm.sh) | [run_somaticsniper.sh](./run_somaticsniper.sh) |
| LoFreq | [parabricks_lofreq_slurm.sh](./parabricks_lofreq_slurm.sh) | [run_lofreq.sh](./run_lofreq.sh) |
| MuSE | [parabricks_muse_slurm.sh](./parabricks_muse_slurm.sh) | [run_muse_WGS.sh](./run_muse_WGS.sh)/[run_muse_WES.sh](./run_muse_WES.sh) |
| Manta | [parabricks_manta_slurm.sh](./parabricks_manta_slurm.sh) | [run_manta.sh](./run_manta.sh) |
| Strelka | [parabricks_strelka_slurm.sh](./parabricks_strelka_slurm.sh) | [run_strelka.sh](./run_strelka.sh) |
| Strelka & Manta | [parabricks_strelkamanta_slurm.sh](./parabricks_strelkamanta_slurm.sh) | [run_strelkamanta.sh](./run_strelkamanta.sh) |

**Use these** if you are starting with BAM files

```bash
run_mutect2.sh config1.txt/config2.txt
run_somaticsniper.sh config1.txt/config2.txt
run_lofreq.sh config1.txt/config2.txt
run_muse_WGS.sh config1.txt/config2.txt
run_muse_WGS.sh config1.txt/config2.txt
run_strelkamanta.sh config1.txt/config2.txt
```

The configuration file can be either the config1.txt presented above, or the config2.txt presented below.

### Configuration2 file:

This is a text file with 4 comma separated columns:
```
1. The folder containing the input BAM files
2. The folder where the generated VCF files should be stored
3. The name for the tumor sample
4. The name for the normal sample
```
- [Example config file 2](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/example/config2_WES_example.txt)

## Notes:
  Parabricks does not currently filter the variants called with Mutect2. We have added an extra step to the pipeline, running the FilterMutectCall from GATK [filter_m2_singularity.sh](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/somatic/filter_m2_singularity.sh) as a final step in the pipeline.


# Example run-times

## Test data:

The runtime has been tested on a publically available [WES dataset](https://github.com/si-medbif/AI-MD-variant-calling/example/README.md) and on a private WGS dataset. Both datasets contained a tumor and a matched normal sample.

 Operation | Time WES | Time WGS |
| --- | --- | --- |
| Mutect2, full             | 19 m |  1 h 32 m |
| Mutect2, full, tumor only |  ? m |  1 h 31 m |
| Mutect2                   |  ? m |      34 m |
| LoFreq                    |  ? m |        NA |
| Manta                     |  3 m |       ? m |
| Muse                      | 55 m |       ? m |
| Strelka                   | 20 m |       ? m |
| SomaticSniper             |  ? m |      54 m |
| Strelka & Manta           |  ? m | 13 h 13 m |

## No-GPU runtimes 

Comparable time spent analysing a WGS data set running each chromosome in parallel:
```
    * WGS (alignment_sort, 32 CPU):   7h
    * WGS (markduplicates)        :   5h 30m
    * WGS (Calculate BQSR)        :      30m
    * WGS (Apply BQSR)            :   4h 40m
    * WGS (Mutect2)               :   3h 10m

    * WGS (Full run)              :  20h 50m
```
|
