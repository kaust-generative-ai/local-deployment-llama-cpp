#!/bin/bash --login

# entire script fails if a single command fails
set -e

# clone the llama.cpp repository
PROJECT_DIR="$PWD"
SRC_DIR="$PROJECT_DIR"/src/llama-cpp
if [ ! -d "$SRC_DIR" ]; then git clone git@github.com:ggerganov/llama.cpp.git "$SRC_DIR"; fi

# activate the conda environment
ENV_PREFIX="$PROJECT_DIR"/env
conda activate "$ENV_PREFIX"

# create the build configuration files
BUILD_DIR="$PROJECT_DIR"/build/llama-cpp
if [ -d "$BUILD_DIR" ]; then rm -rf "$BUILD_DIR"; fi

cmake -S "$SRC_DIR" -B "$BUILD_DIR" \
    -DCMAKE_INSTALL_PREFIX="$ENV_PREFIX" `# install binaries into conda environment` \
    -DGGML_METAL=OFF            `# disable support for metal on mac silicon` \
    -DGGML_LLAMAFILE=OFF        `# support for Q4_0_4_4 quantization` \
    -DGGML_BLAS=ON              `# support for CPU accleration using BLAS` \
    -DGGML_BLAS_VENDOR=OpenBLAS

# build llama.cpp
cmake --build "$BUILD_DIR" --config Release 

# install the compiled binaries into the conda environment
cmake --install "$BUILD_DIR" --prefix "$ENV_PREFIX"

# remove the source directory
rm -rf "$SRC_DIR"

# deactivate the conda environment
conda deactivate
