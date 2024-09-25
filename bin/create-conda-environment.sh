#!/bin/bash --login

# entire script fails if a single command fails
set -e

# create the conda environment
PROJECT_DIR="$PWD"
ENV_PREFIX="$PROJECT_DIR"/env
ENV_FILE="${1-environment.yml}"
mamba env create --prefix $ENV_PREFIX --file "$PROJECT_DIR"/"$ENV_FILE" --yes
