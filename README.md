# AI-MD-variant-calling

## Description

This repository contains scripts and information for doing variant detection on a HPC cluster with GPU support. Input data can be either whole genome sequence (WGS) or whole exome sequence (WES). Currently there is a section on somatic variant detection. Germline and RNA variant detection will be added at a later date.

## [Mahidol HPC-AI Cluster](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/documents/hpc-server.md)

Currently, the following GPU resources are available to use:
* 1 x DGX A100 Server with 8 x NVIDIA A100-80GB GPUs
* 2 x DGX A100 Server with 8 x NVIDIA A100-40GB GPUs

Note that the job submissions on the cluster is handled by one of two job schedulers:
* [Kubernetes](https://kubernetes.io/docs/tutorials/)
* [Slurm](https://slurm.schedmd.com/quickstart.html)

Anyone wanting to submit jobs manually will have to use either of these systems. We have provided a short introduction for [slurm](https://github.com/si-medbif/AI-MD-variant-calling/documents/slurm.md).

## [NVIDIA CLARA PARABRICKS](https://docs.nvidia.com/clara/parabricks/3.7.0/index.html)

The GPU software used in this project is from NVIDIA and is called CLARA PARABRICKS Pipelines. The pipelines cover analysis from read data (FASTQ-files) to called variants (VCF-files). We have provided a [short introduction](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/documents/parabricks.md#nvidia-clara-parabricks). For the full documentation including any additional options and updates, please visit [NVIDIA CLARA PARABRICKS](https://docs.nvidia.com/clara/parabricks/3.7.0/index.html)

## [Getting started](https://github.com/si-medbif/AI-MD-variant-calling/example/tutorial.md)

Download this repository and add it to the PATH to gain access to the wrapper scripts used to submit jobs to SLURM.
```bash
git clone https://github.com/si-medbif/AI-MD-variant-calling.git
export PATH="${PWD}/AI-MD-variant-calling/somatic":$PATH
export PATH="${PWD}/AI-MD-variant-calling/support":$PATH
export PATH="${PWD}/AI-MD-variant-calling/germline":$PATH
export PATH="${PWD}/AI-MD-variant-calling/rna":$PATH
```

There are tutorials for calling [germline](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/example/tutorial_germline.md#step-by-step-tutorial-to-analyse-an-example-wes-dataset-from-a-first-time-perspective), [somatic](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/example/tutorial.md#step-by-step-tutorial-to-analyse-an-example-wes-dataset-from-a-first-time-perspective) and [RNA-seq](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/example/tutorial_rna.md#step-by-step-tutorial-to-analyse-an-example-WTS/RNAseq-dataset-from-a-first-time-perspective) variants in the [example](https://github.com/si-medbif/AI-MD-variant-calling/tree/main/example#example-scripts-and-data-sets) section.

## [Germline variant detection](https://github.com/si-medbif/AI-MD-variant-calling/tree/main/germline#germline-variant-detection)

The main ParaBricks pipeline is using BWA for read mapping, GATK for processing of BAM files and either the GATK-HaplotypeCaller or the Google DeepVariant for variant calling. 

Other stand-alone variant callers are also available:

| Software     |  SNP | INDEL |  SV  | GPU accelerated |
| ------------ |  :-: | :---: | :--: | :-------------: |
| HaplotypeCaller | V | V | X | V |
| DeepVariant  | V | V | X | V |
| Strelka      | V | V | X | X |
| Smoove       | X | X | V | X |
| Manta        | X | X | V | X |

## [Somatic variant detection](https://github.com/si-medbif/AI-MD-variant-calling/tree/main/somatic#somatic-variant-detection)

The main ParaBricks pipeline is using BWA for read mapping, GATK for processing of BAM files and GATK-Mutect2 for variant calling.

There are also a selection of other somatic variant callers available:

| Software     | Tumor-Normal | Tumor-Only | SNP | INDEL |  SV  | GPU accelerated |
| ------------ | :----------: | :--------: | :-: | :---: | :--: | :-------------: |
| Mutect2      | V            | V          | V   | V     | X    | V               |
| SomatcSniper | V            | X          | V   | V     | X    | X               |
| LoFreq       | V            | X          | V   | V     | X    | V               |
| MuSE         | V            | X          | V   | X     | X    | X               |
| Manta        | V            | X          | X   | X     | V    | X               |
| Strelka      | V            | X          | V   | V     | X    | X               |

- read more in the section for [somatic variant calling](https://github.com/si-medbif/AI-MD-variant-calling/tree/main/somatic#somatic-variant-detection)

## [RNA variant detection](https://github.com/si-medbif/AI-MD-variant-calling/tree/develop/rna#rna-variant-detection)

The main ParaBricks pipeline is using STAR for read mapping, GATK for processing of the BAM files and GATK-HaplotypeCaller for variant calling. After generating the BAM files, other types of variant calling can also be used.

Additionally, the tool Arriba is provided to perform fusion detection.
