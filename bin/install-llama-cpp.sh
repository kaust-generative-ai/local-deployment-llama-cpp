#!/bin/bash

# entire script fails if a single command fails
set -e

# set project paths
PROJECT_DIR="$PWD"
ENV_PREFIX="$PROJECT_DIR"/env
SRC_DIR="$PROJECT_DIR"/src

# download a particular release archive from https://github.com/ggerganov/llama.cpp/releases
URL="$1"
RELEASE_ARCHIVE="${URL##*/}"
curl --location --output "$SRC_DIR"/"$RELEASE_ARCHIVE" "$URL"

# extract the contents of the release into the Conda environment bin/ directory
unzip -joq "$SRC_DIR"/"$RELEASE_ARCHIVE" -d "$ENV_PREFIX"/bin

# remove the zip archive
rm "$SRC_DIR"/"$RELEASE_ARCHIVE"