#!/bin/bash

# CUDA
VENV_NVIDIA="${SCRIPT_DIR}/.venv/lib/python3.12/site-packages/nvidia"
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:/usr/local/cuda/lib64:${VENV_NVIDIA}/cu13/lib:${VENV_NVIDIA}/nvjitlink/lib:${VENV_NVIDIA}/cublas/lib:${VENV_NVIDIA}/cudnn/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"

# PATH 先頭に /usr/bin を置いて as/ld も確実にシステム版を使う
export PATH="/usr/bin:/usr/local/bin:${PATH}"
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
