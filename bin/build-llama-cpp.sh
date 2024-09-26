#!/bin/bash --login

# entire script fails if a single command fails
set -e

# clone the llama.cpp repository
PROJECT_DIR="$PWD"
SRC_DIR="$PROJECT_DIR"/src/llama-cpp
git clone git@github.com:ggerganov/llama.cpp.git "$SRC_DIR"

# activate the conda environment
ENV_PREFIX="$PROJECT_DIR"/env
conda activate "$ENV_PREFIX"

# compile using cmake with BLAS support
BUILD_DIR="$PROJECT_DIR"/build/llama-cpp
cmake -S "$SRC_DIR" -B "$BUILD_DIR" \
    -DGGML_METAL=OFF            `# disable support for metal on mac silicon` \
    -DGGML_LLAMAFILE=OFF        `# support for Q4_0_4_4 quantization` \
    -DGGML_BLAS=ON              `# support for CPU accleration using BLAS` \
    -DGGML_BLAS_VENDOR=OpenBLAS

cmake --build "$BUILD_DIR" --config Release

# symlink llama.cpp binaries into the Conda environment bin directory
ln -sf "$BUILD_DIR"/bin/* "$ENV_PREFIX"/bin

# remove the llama.cpp source code
rm -rf "$SRC_DIR"

# deactivate the conda environment
conda deactivate
