#!/bin/bash

# entire script fails if a single command fails
set -e

# download the release for a particular build of llama.cpp
BUILD="${1-b3822}" 
RELEASE_ARCHIVE=llama-"$BUILD"-bin-macos-arm64.zip
URL=https://github.com/ggerganov/llama.cpp/releases/download/"$BUILD"/"$RELEASE_ARCHIVE"
curl --location --output /tmp/"$RELEASE_ARCHIVE" "$URL"

# extract the contents of the release into the bin directory
PROJECT_DIR="$PWD"
TARGET_DIR="$PROJECT_DIR"/bin/llama-cpp/"$BUILD"
mkdir -p "$TARGET_DIR"
unzip -joq /tmp/"$RELEASE_ARCHIVE" -d "$TARGET_DIR"

# create symbolic links to conda environment bin directory
ENV_PREFIX="$PROJECT_DIR"/env
ln -sf "$TARGET_DIR"/* "$ENV_PREFIX"/bin
