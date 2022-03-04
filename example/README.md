# Example scripts and data sets

## Somatic tutorial

We have provided a [full run-through](./tutorial.md) of a somatic analysis of a matched tumor-normal WES dataset.

## Example configuration files

The provided configuration files can be used as input to run either the full pipeline ([config1_WES_example.txt](./config1_WES_example.txt)) or the variant calling step ([config2_WES_example.txt](./config2_WES_example.txt)), just change the location you want to create the BAM files and the VCF files.
```bash
run_full_somatic.sh config1_WES_example.txt
run_mutect2.sh config2_WES_example.txt
```
## Example data set

The example dataset are collected from [MAQC-IV (also known as SEQC2)](https://www.fda.gov/science-research/bioinformatics-tools/microarraysequencing-quality-control-maqcseqc#MAQC_IV). [Data repository](https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/data/).

The data was downloaded as BAM files and converted to FASTQ using the Parabricks function bam2fq.
