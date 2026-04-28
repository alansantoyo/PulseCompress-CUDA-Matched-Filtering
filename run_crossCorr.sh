#!/bin/bash
#SBATCH --export=/usr/local/cuda/bin
#SBATCH --gres=gpu:1


cmake -B build
cmake --build build

echo "********************************************"
echo "** Computing cross correlation for signal **"
echo "********************************************"


