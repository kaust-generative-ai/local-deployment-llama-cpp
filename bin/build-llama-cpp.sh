#!/bin/bash

# entire script fails if a single command fails
set -e

# clone the llama.cpp repository
PROJECT_DIR="$PWD"
SRC_DIR="$PROJECT_DIR"/src/llama-cpp
if [ ! -d "$SRC_DIR" ]; then git clone https://github.com/ggerganov/llama.cpp.git "$SRC_DIR"; fi

# create the build configuration files
BUILD_DIR="$PROJECT_DIR"/build/llama-cpp
if [ -d "$BUILD_DIR" ]; then rm -rf "$BUILD_DIR"; fi

cmake -S "$SRC_DIR" -B "$BUILD_DIR" \
    -DCMAKE_INSTALL_PREFIX="$CONDA_PREFIX"      `# install binaries into conda environment` \
    -DCMAKE_INSTALL_RPATH="$CONDA_PREFIX"/lib   `# insure that dyanmic libs can be found at runtime` \
    -DGGML_METAL=OFF                            `# disable support for metal on mac silicon` \
    -DGGML_LLAMAFILE=OFF                        `# support for Q4_0_4_4 quantization` \
    -DGGML_BLAS=ON                              `# support for CPU accleration using BLAS` \
    -DGGML_BLAS_VENDOR=OpenBLAS

# build llama.cpp
cmake --build "$BUILD_DIR" --config Release 

# install the compiled binaries into the conda environment
cmake --install "$BUILD_DIR" --prefix "$CONDA_PREFIX"

# remove the source directory
rm -rf "$SRC_DIR"

# remove the build directory
rm -rf "$BUILD_DIR"
