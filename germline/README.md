# Germline variant detection

## Full pipeline

| Task | Main script | Helper script |
| --- | --- | --- |
| Full | [parabricks_germline_slurm.sh](./parabricks_germline_slurm.sh) | [run_full_germline.sh](./run_full_germline.sh) |
| Full DeepVariant, WES/WGS | [parabricks_deepvariant-germline_slurm.sh](./parabricks_deepvariant-germline_slurm.sh) | [run_full_deepvariant-germline_WES.sh](./run_full_deepvariant-germline_WES.sh)/[run_full_deepvariant-germline_WGS.sh](./run_full_deepvariant-germline_WGS.sh) |

**Use Full version** if you start with fastq

```
run_full_germline.sh config.txt
run_full_deepvariant-germline_WES.sh config.txt
run_full_deepvariant-germline_WGS.sh config.txt
```

The helper scripts are a convenient way of running the pipeline. The input is a configuration file with all the details about the samples to be run, see below for details. The configuration file can also contain information about more than one sample.

The main scripts contain reasonable default settings for the [slurm](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/documents/slurm.md) parameters, as well as the Parabricks command line. Information about the input files and folder locations have to be either provided on the command line or edited into the script file.


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
- [Example config file](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/example/config_germline_WES.txt)


## Individual variant callers

After generating the BAM files, there are several variant callers available

| Task | Main script | Helper script |
| --- | --- | --- |
| Haplotypecaller | [parabricks_haplotypecaller_slurm.sh](./parabricks_haplotypecaller_slurm.sh) | [run_haplotypecaller.sh](./run_haplotypecaller.sh) |
| DeepVariant WES/WGS | [parabricks_deepvariant_slurm.sh](./parabricks_deepvariant_slurm.sh) | [run_deepvariant_WES.sh](./run_deepvariant_WES.sh)/[run_deepvariant_WGS.sh](./run_deepvariant_WGS.sh) |
| Smoove | [parabricks_smoove_slurm.sh](./parabricks_smoove_slurm.sh) | [run_smoove.sh](./run_smoove.sh) |

**Use this version** if you already have BAM. 

## Variant calling step, from BAM to VCF
```
run_haplotypecaller.sh config.txt
run_deepvariant_WES.sh config.txt
run_deepvariant_WGS.sh config.txt
run_smoove.sh config.txt
run_manta_germline.sh config.txt
run_strelka_germline.sh config.txt
```

**Note** that the configuration file is the same as for the full pipeline.

# Joint variant calling

The scripts can be run using the same config file as above. All samples in the file will be combined into a single analysis. 

Haplotypecaller trios only supports *two* or *three* samples.
Manta and Strelka were designed to only support family scale cohort sizes, i.e. up to 10s of samples. 

```bash
run_haplotypecaller_trios.sh config.txt
run_manta_joint.sh config.txt
run_strelka_joint.sh config.txt
```

# Example run-times

## Test data:

The runtime has been tested on three publically available [WES dataset](https://github.com/si-medbif/AI-MD-variant-calling/example/README.md) and on a private WGS dataset.

| Operation | Time WES | Time WGS |
| --- | --- | --- |
| HaplotypeCaller, full |  6 m | 44 m |
| DeepVariant, full     | 11 m | 1 h 42 m |
| HaplotypeCaller       |  6 m | 28 m |
| DeepVariant           |  5 m | 35 m |
| Smoove                |  5 m | 12 m |
| Manta                 |  2 m | 19 m |
| Strelka               | 17 m | 3 h 37 m |
| CNVkit                |  5 m | 16 m |
