## Mahidol HPC-AI Cluster

## Job scheduler

The cluster operates two job schedulers to manage the workloads:
* [Kubernetes](https://kubernetes.io/docs/tutorials/) 
* [Slurm](https://slurm.schedmd.com/quickstart.html) 

A job scheduler handles everything related to submitted tasks: allocating resources, managing the queue and starting tasks when resources are available, logging and tracking tasks that are either waiting, running or paused.

We primarily use SLURM for Clara Parabricks related jobs on this repository. Please check out the brief [documentation](https://github.com/si-medbif/AI-MD-variant-calling/blob/main/documents/slurm.md) to get started or go to the [SLURM](https://slurm.schedmd.com/) main page for the complete documentation.

There is also a web-based user interface at [https://hpc.mahidol.ac.th/](https://hpc.mahidol.ac.th/) for job submissions. Instructions on how to use that interface will be added later.

## CPU specifications

### ICT-HPC server specifications

  * IP address: 10.134.1.9
  * Vendor id: AuthenticAMD
  * Model name: AMD EPYC 7742 64-Core Processor
  * Operating System: Ubuntu 20.04.2 LTS (focal)
  * CPUs: 256
  * Memory (RAM): 2TB

## GPU specifications

### ICT-HPC server specifications

  * 1 x DGX A100 Server with 8 x NVIDIA A100-80GB GPUs 
  * 2 x DGX A100 Server with 8 x NVIDIA A100-40GB GPUs
