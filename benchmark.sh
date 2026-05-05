#!/bin/bash
#SBATCH --export=/usr/local/cuda/bin
#SBATCH --gres=gpu:1export TMPDIR=$HOME/tmp/ncu-lock

export TMPDIR=$HOME/tmp/ncu-lock

ncu --set full -o profile_01_baseline -f ./bin/matched_filter

ncu --set full -o profile_02_tiled -f ./bin/matched_filter_tiled

ncu --set full -o profile_03_tiled_coarsened -f ./bin/matched_filter_tiled_coarsened
