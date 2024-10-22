#!/bin/bash

# entire script fails if a single command fails
set -e

# clone the llama.cpp repository
PROJECT_DIR="$PWD"
SRC_DIR="$PROJECT_DIR"/src
if [ ! -d "$SRC_DIR"/llama-cpp ]; then git clone https://github.com/ggerganov/llama.cpp.git "$SRC_DIR"/llama-cpp; fi

# clone the huggingface repository
HF_REPO="$1"
MODEL_DIR="$PROJECT_DIR"/models
if [ ! -d "$MODEL_DIR"/"$HF_REPO" ]; then git-lfs clone https://huggingface.co/"$HF_REPO" "$MODEL_DIR"/"$HF_REPO"; fi

# convert to GGUF format
OUTTYPE="${2-bf16}"
MODEL_FILE="$(basename "$MODEL_DIR"/"$HF_REPO")-"$OUTTYPE".gguf"
OUTFILE="$MODEL_DIR"/"$MODEL_FILE"

export TOKENIZERS_PARALLELISM=false
python "$SRC_DIR"/llama-cpp/convert_hf_to_gguf.py "$MODEL_DIR"/"$HF_REPO" --outtype "$OUTTYPE" --outfile "$OUTFILE"

# quantize the GGUF model
QUANTTYPE="${3-Q4_K_M}"
QUANTIZED_MODEL_FILE="$(basename "$MODEL_DIR"/"$HF_REPO")-"$QUANTTYPE".gguf"
llama-quantize "$OUTFILE" "$QUANTIZED_MODEL_FILE" "$QUANTTYPE"
