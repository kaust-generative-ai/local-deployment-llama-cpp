#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --partition=debug
#SBATCH --job-name=create-conda-environment
#SBATCH --mail-type=ALL
#SBATCH --output=bin/%x-%j-slurm.out
#SBATCH --error=bin/%x-%j-slurm.err

# create the conda environment
./bin/create-conda-environment.sh

# building llama-cpp
conda run --prefix "$PWD"/env ./bin/build-llama-cpp.sh
