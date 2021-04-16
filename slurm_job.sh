#!/bin/bash

# This is an example file, in case you are working on a 
# a cluster that uses SLURM instead of PBS
# We will NOT need this file for the MDAWO 

#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --nodelist=
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=4000
#SBATCH --job-name="slurmt"
#SBATCH --output=test.output
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH --requeue

singularity run -B  /<path_to>/my_analysis:/mnt/analysis pema_v.2.1.0.sif
