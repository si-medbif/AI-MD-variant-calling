# RNA variant detection

## Full pipeline

| Task | Main script | Helper script |
| --- | --- | --- |
| Full | [parabricks_rna_slurm.sh](./parabricks_rna_slurm.sh) | [run_full_rna.sh](./run_full_rna.sh) |

**Use Full version** if you start with fastq

```
run_full_rna.sh config.txt
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
- [Example config file](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/example/config_RNA.txt)


# Calling Fusion mutations

```bash
run_arriba.sh config.txt
```

# Example run-times

## Test data:

The runtime has been tested on a publicly available [blood RNA dataset](https://github.com/si-medbif/AI-MD-variant-calling/example/README.md).

Full run times, FASTQ to VCF, using the main pipeline with STAR and the GATK software packages:
| Operation | Time, 2 GPU |
| --- | --- |
| Haplotypecaller, Full | 32 m |
| Fastq2Bam | 17 m |
| SplitNCigar | 11 m |
| HaplotypeCaller | 4 m |
| Arriba | 13 m |
