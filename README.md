# HPC-pipelines

## Description

This repository contains scripts and information for doing variant detection on a HPC cluster with GPU support. Input data can be either whole genome sequence (WGS) or whole exome sequence (WES). Currently there is a section on somatic variant detection. Germline and RNA variant detection will be added at a later date.

## Mahidol HPC-AI Cluster

Currently, the following GPU resources are available to use:
* 1 x DGX A100 Server with 8 x NVIDIA A100-80GB GPUs
* 2 x DGX A100 Server with 8 x NVIDIA A100-40GB GPUs

The cluster operates two job schedulers to manage the workloads:
* [Kubernetes](https://kubernetes.io/docs/tutorials/)
* [Slurm](https://slurm.schedmd.com/quickstart.html)

A job scheduler handles everything related to submitted tasks: allocating resources, managing the queue and starting tasks when resources are available, logging and tracking tasks that are either waiting, running or paused. 
We primarily use SLURM for Clara Parabricks related jobs on this repository. Please check out the brief [documentation](https://github.com/si-medbif/hpc-pipelines/blob/main/documents/slurm.md) to get started or go to the [SLURM](https://slurm.schedmd.com/) main page for the complete documentation.

## NVIDIA CLARA PARABRICKS

The GPU software used in this project is from NVIDIA and is called CLARA PARABRICKS Pipelines. The pipeline cover analysis from read data (FASTQ-files) to called variants (VCF-files). A short introduction is provided [here](https://github.com/si-medbif/hpc-pipelines/blob/main/documents/parabricks.md#nvidia-clara-parabricks). For the full documentation including any additional options and updates, please visit [NVIDIA CLARA PARABRICKS](https://docs.nvidia.com/clara/parabricks/3.7.0/index.html)

## Getting started

Download this repository to add it to the PATH to gain access to the wrapper scripts used to submit jobs to SLURM.
```bash
git clone https://github.com/si-medbif/hpc-pipelines.git
export PATH="${PWD}/hpc-pipelines/somatic":$PATH
export PATH="${PWD}/hpc-pipelines/support":$PATH
```

A test data set and a [tutorial](https://github.com/si-medbif/hpc-pipelines/example/tutorial.md) for a complete analysis is provided in the [example](https://github.com/si-medbif/hpc-pipelines/example) section.

## Germline variant detection

Coming soon ...

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

- read more in the section for [somatic varinat calling](https://github.com/si-medbif/hpc-pipelines/tree/main/somatic#somatic-variant-detection)

## RNA variant detection

Coming soon ...
