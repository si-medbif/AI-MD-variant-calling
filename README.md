# HPC-pipelines

## Description

This repository contains scripts and information for doing variant detection on a HPC cluster with GPU support. Input data can be either whole genome sequence (WGS) or whole exome sequence (WES). Currently there is a section on somatic variant detection, with germline detection being added at a later date.

The GPU software used in this project is from NVIDIA and is called CLARA PARABRICKS Pipelines. The pipeline cover analysis from read data (FASTQ-files) to called variants (VCF-files). For the full documentation including any additional options and updates, please visit [NVIDIA CLARA PARABRICKS](https://docs.nvidia.com/clara/parabricks/v3.6/text/software_overview.html)

The pipelines for calling germline and somatic variants are further described via the links below.

## Germline variant detection

## [Somatic variant detection](https://github.com/si-medbif/hpc-pipelines/tree/main/somatic#somatic-variant-detection)

PB is using BWA for read mapping, and GATK for processing of BAM files.

Available callers for somatic variants are currently:

| Software     | Tumor-Normal | Tumor-Only | SNP | INDEL |  SV  | GPU accelerated |
| ------------ | :----------: | :--------: | :-: | :---: | :--: | :-------------: |
| Mutect2      | V            | V          | V   | V     | X    | V               |
| SomatcSniper | V            | X          | V   | V     | X    | X               |
| LoFreq       | V            | X          | V   | V     | X    | V               |
| Manta        | V            | X          | X   | X     | V    | X               |
| Strelka      | V            | X          | V   | V     | V    | X               |

## Additional software

Steps not included in the PARABRICKS package can most easily be installed through the use of singularity images.

Since the main somatic pipeline does not (yet) filter the variant calls, when this is needed it's possible to use the GATK software to run the FilterMutectCalls process manually on the output files.

Creating the singularit image of GATK:
    singularity build gatk.4.0.12.0.sif docker://broadinstitute/gatk:4.0.12.0

The list of available versions can be found on [DockerHub](https://hub.docker.com/r/broadinstitute/gatk/tags). The main thing for this use case is that Mutect2 versions starting from 4.1 outputs a stats-file that is required for filtering. The 4.0.12.0 version is the last before version 4.1.
