#SLURM

The server is using the SLURM job scheduler so all scripts have to be submitted through this software.

The basic way to do this is to add the command to a slurm template run script, and then use the sbatch command to submit it. 
For the complete information about SBATCH: https://slurm.schedmd.com/sbatch.html.

##Example SLURM template for running parabricks

```
#!/bin/bash

#SBATCH --job-name=somatic-parabricks    # Job name                   # default: script name or sbatch
#SBATCH --ntasks=1                       # Number of tasks            # default: 1 task per node
#SBATCH --output=job%j_somatic.log       # Output file                # default: slurm-<jobid>.out
#SBATCH --nodes=1                        # Req min-max of nodes       # default: 1-as many as possible to satisfy the job without delay
#SBATCH --gres=gpu:2                     # Number of GPUs requested   # default: none (0) 
#SBATCH --time=8:00:00                   # Time limit hrs:min:sec     # default: 01:00:00 (+1 hours of extra overtime limit)
#SBATCH --nodelist=omega                 # Node(s) to submit the job
#SBATCH --export=ALL                     # Pass the env var
#SBATCH --partition=batch                # Req specific partition     # default: batch
#SBATCH --mem=100gb                      # Memory size requested      # default: 4gb
#SBATCH --cpus-per-task=24               # Number of CPUs per task    # default: 1 CPU per task

```

The [recommended](https://docs.nvidia.com/clara/parabricks/3.7.0/GettingStarted.html#installation-requirements) minimum resources based on the chosen number of GPU's are:

| GPU | CPU | MEM |
| :---: | :---: | :---: |
| 2 | 24 | 100GB |
| 4 | 32 | 196GB |
| 8 | 48 | 392GB | 
