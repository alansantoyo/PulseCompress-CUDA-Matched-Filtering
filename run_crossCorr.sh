#!/bin/bash
#SBATCH --export=/usr/local/cuda/bin
#SBATCH --gres=gpu:1


cmake -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build

echo "********************************************"
echo "** Computing cross correlation for signal **"
echo "********************************************"

./bin/matched_filter
