# HPC-pipelines

## Description

This repository contains scripts and information for doing variant detection on a HPC cluster with GPU support. Input data can be either whole genome sequence (WGS) or whole exome sequence (WES). Currently there is a section on somatic variant detection, with germline detection being added at a later date.

The GPU software used in this project is from NVIDIA and is called CLARA PARABRICKS Pipelines. The pipeline cover analysis from read data (FASTQ-files) to called variants (VCF-files). For the full documentation including any additional options and updates, please visit [NVIDIA CLARA PARABRICKS](https://docs.nvidia.com/clara/parabricks/3.7.0/index.html)

The pipelines for calling germline and somatic variants are further described via the links below.

*Note:* All scripts and documentation was created with Parabricks version 3.6. The current Parabricks version on the server is 3.7 so there might be minor differences.

## Getting started

Download this repository and move into the created folder
```bash
git clone https://github.com/si-medbif/hpc-pipelines.git
cd hpc-pipelines
```

## Germline variant detection

## [Somatic variant detection](https://github.com/si-medbif/hpc-pipelines/tree/main/somatic#somatic-variant-detection)

ParaBricks is using BWA for read mapping, and GATK for processing of BAM files.

Available callers for somatic variants are currently:

| Software     | Tumor-Normal | Tumor-Only | SNP | INDEL |  SV  | GPU accelerated |
| ------------ | :----------: | :--------: | :-: | :---: | :--: | :-------------: |
| Mutect2      | V            | V          | V   | V     | X    | V               |
| SomatcSniper | V            | X          | V   | V     | X    | X               |
| LoFreq       | V            | X          | V   | V     | X    | V               |
| Manta        | V            | X          | X   | X     | V    | X               |
| Strelka      | V            | X          | V   | V     | V    | X               |



