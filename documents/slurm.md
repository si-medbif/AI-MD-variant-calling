# SLURM

The server is using the slurm job scheduler so all scripts have to be submitted through this software.

The basic way to do this is to add the command to a slurm template run script, and then use the *sbatch* command to submit it. 
For the complete information about SBATCH: https://slurm.schedmd.com/sbatch.html.

##Example SLURM template for running parabricks

The name of the job as it will be seen while running and the name of the log-file.
```
#!/bin/bash

#SBATCH --job-name=somatic-parabricks    # Job name                   # default: script name or sbatch
#SBATCH --output=job%j_somatic.log       # Output file                # default: slurm-<jobid>.out
```
Various settings, usually best kept as default.
```
#SBATCH --ntasks=1                       # Number of tasks            # default: 1 task per node
#SBATCH --nodes=1                        # Req min-max of nodes       # default: 1-as many as possible to satisfy the job without delay
#SBATCH --nodelist=omega                 # Node(s) to submit the job
#SBATCH --export=ALL                     # Pass the env var
#SBATCH --partition=batch                # Req specific partition     # default: batch
```
Requested resources.
```
#SBATCH --gres=gpu:2                     # Number of GPUs requested   # default: none (0) 
#SBATCH --mem=100gb                      # Memory size requested      # default: 4gb
#SBATCH --cpus-per-task=24               # Number of CPUs per task    # default: 1 CPU per task
#SBATCH --time=8:00:00                   # Time limit hrs:min:sec     # default: 01:00:00 (+1 hours of extra overtime limit)
```

The [recommended](https://docs.nvidia.com/clara/parabricks/3.7.0/GettingStarted.html#installation-requirements) minimum resources based on the chosen number of GPU's are:

| GPU | CPU | MEM |
| :---: | :---: | :---: |
| 2 | 24 | 100GB |
| 4 | 32 | 196GB |
| 8 | 48 | 392GB | 
