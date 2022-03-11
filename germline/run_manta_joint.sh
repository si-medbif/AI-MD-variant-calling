#! /bin/bash

SAMPLES=$1

sbatch parabricks_manta-joint_slurm.sh ${SAMPLES}
