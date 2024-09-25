#!/bin/bash --login

# entire script fails if a single command fails
set -e

# create the conda environment
PROJECT_DIR="$PWD"
ENV_PREFIX="$PROJECT_DIR"/env
mamba env create --prefix $ENV_PREFIX --file "$PROJECT_DIR"/environment-gpu.yml --yes

# install llama-cpp-python with GPU support
conda activate "$ENV_PREFIX"
CMAKE_ARGS="-DGGML_CUDA=ON" FORCE_CMAKE=1 pip install --no-cache-dir llama-cpp-python
conda deactivate
