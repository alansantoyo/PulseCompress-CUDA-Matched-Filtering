#!/bin/bash
#SBATCH --export=/usr/local/cuda/bin
#SBATCH --gres=gpu:1


cmake -B build
cmake --build build

echo "*****************************************"
echo "** Generating filter and return signal **"
echo "*****************************************"

python generate_data.py

echo "** Data generated **"
