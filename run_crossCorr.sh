#!/bin/bash
#SBATCH --export=/usr/local/cuda/bin
#SBATCH --gres=gpu:1


cmake -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build


if [ -e "./bin/matched_filter" ]; then
	echo "Launching the program..."
	./bin/matched_filter
	echo "********************************************"
	echo "** Computing cross correlation for signal **"
	echo "********************************************"

	
fi
