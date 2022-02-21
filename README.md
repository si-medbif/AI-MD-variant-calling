# HPC-pipelines

## Description

This repository contains scripts and information for doing variant detection on a HPC cluster with GPU support. Input data can be either whole genome sequence (WGS) or whole exome sequence (WES). Currently there is a section on somatic variant detection, with germline detection being added at a later date.

The GPU software used in this project is from NVIDIA and is called CLARA PARABRICKS Pipelines. The pipeline cover analysis from read data (FASTQ-files) to called variants (VCF-files). 

Documentation site for software: https://docs.nvidia.com/clara/parabricks/v3.6/text/software_overview.html


## Germline variant detection

## Somatic variant detection

PB is using BWA for read mapping, and GATK for processing of BAM files.

Available callers for somatic variants are currently:

* Mutect2
  * Mutect2 can call somatic variants from either matched Tumor-Normal data or Tumor-only data.
* SomatcSniper
  * SomaticSniper can call somatic variants from matched Tumor-Normal data. The tool does not currently seem to be GPU accelrated.
* LoFreq
  * LoFreq can call somatic variants from matched Tumor-Normal data
* Manta
  * Manta calls somatic structural variants and indels from matched Tumor-Normal data. This tool is not GPU accelerated.
* Strelka
  * Strelka can call somatic SNP variants and indels in combination with Manta using matched Tumor-Normal data. This tool is not GPU accelerated.
