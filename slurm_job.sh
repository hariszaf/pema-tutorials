#!/bin/bash

#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --nodelist=
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=4000
#SBATCH --job-name="mdawo_v2"
#SBATCH --output=16S_phylos.output
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH --requeue


singularity run -B  /home1/haris/metabar_pipeline/mdawo/my_analysis:/mnt/analysis pema_v.2.1.0.sif
