#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --gpus-per-node=a100:1
#SBATCH --cpus-per-gpu=6
#SBATCH --mem=64G
#SBATCH --job-name=create-conda-environment-nvidia-gpu
#SBATCH --mail-type=ALL
#SBATCH --output=bin/%x-%j-slurm.out
#SBATCH --error=bin/%x-%j-slurm.err

# create the conda environment
./bin/create-conda-environment.sh environment-nvidia-gpu.yml

# building llama-cpp
conda run --prefix "$PWD"/env ./bin/build-llama-cpp-nvidia-gpu.sh
