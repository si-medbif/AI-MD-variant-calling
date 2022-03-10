# Germline variant detection

## Options for running the parabricks scripts

The following scripts are ready for use depending on which analysis is required

### Full pipeline
| Task | Main script | Helper script |
| --- | --- | --- |
| Full | [parabricks_germline_slurm.sh](./parabricks_germline_slurm.sh) | [run_full_germline.sh](./run_full_germline.sh) |

**Use Full version** if you start with fastq

### Just variant calling
| Task | Main script | Helper script |
| --- | --- | --- |
| Haplotypecaller | [parabricks_haplotypecaller_slurm.sh](./parabricks_haplotypecaller_slurm.sh) | [run_haplotypecaller.sh](./run_haplotypecaller.sh) |

**Use this version** if you already have BAM

The main scripts contain reasonable default settings for the [slurm](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/documents/slurm.md) parameters, as well as the Parabricks command line. Information about the input files and folder locations have to be either provided on the command line or edited into the script file.

An alternative way of running the main scripts is by using the helper scripts. The difference is that here the input is a configuration file with all the details about the samples to be run. The configuration file can also contain information about several samples, each line being a different sample.

## Full pipeline from FASTQ to VCF:
```
run_full_germline.sh config1.txt        # 
```

  The main scripts to run the whole analysis from FASTQ to VCF. The config-file lists information for one sample per line with a format as described below. In this way several samples can be queued up for analysis.

## Variant calling
After generating the tumor and normal BAM files, there are several germline variant callers available

### Configuration file

This is a text file with 6 comma separated columns:
```
1. The folder containing the FASTQ files
2. The folder where the generated BAM files should be stored
3. The folder where the generated VCF files should be stored
4. The name for the normal sample
5. The 1st FASTQ file for the normal sample (leave empty if no fastq file is present)
6. The 2nd FASTQ file for the normal sample (leave empty if no fastq file is present)
```
- [Example config file 1](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/example/config1_WES_example.txt)


# Example run-times

## Test data:

The runtime has been tested on a publically available [WES dataset](https://github.com/si-medbif/AI-MD-variant-calling/example/README.md) and on a private WGS dataset. Both datasets contained a tumor and a matched normal sample.

Full run times, FASTQ to VCF, using the main pipeline with BWA and the GATK software packages:
```
    * WES, HC:                  6m (VCF)
    * WES, DeepVariant:        11m (VCF)
    * WGS, HC:                 44m (VCF) (filtered VCF)
```

Varint calling
```bash
    * WGS, haplotypecaller : 24m (.g.vcf)

```
