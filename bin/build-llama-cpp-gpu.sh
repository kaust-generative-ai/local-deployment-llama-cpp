#!/bin/bash

# entire script fails if a single command fails
set -e

# clone the llama.cpp repository
CLONE_DIR=/tmp/llama.cpp
git clone git@github.com:ggerganov/llama.cpp.git $CLONE_DIR

# compile using cmake
PROJECT_DIR="$PWD"
BUILD_DIR="$PROJECT_DIR"/build
cmake -S "$CLONE_DIR" -B "$BUILD_DIR" \
    -DGGML_LLAMAFILE=OFF `# support for Q4_0_4_4 quantization` \
    -DGGML_CUDA=ON       `# support for NVIDIA GPU accleration`

cmake --build "$BUILD_DIR" --config Release

# symlink llama.cpp binaries into the Conda environment bin directory
ENV_PREFIX="$PROJECT_DIR"/env
ln -sf "$BUILD_DIR"/bin/* "$ENV_PREFIX"/bin
