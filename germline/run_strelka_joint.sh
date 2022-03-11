#! /bin/bash

SAMPLES=$1

sbatch parabricks_strelka-joint_slurm.sh ${SAMPLES}
