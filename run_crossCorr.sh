#!/bin/bash
#SBATCH --export=/usr/local/cuda/bin
#SBATCH --gres=gpu:1

if [ -f "./MatchedFilter/src/output.bin" ]; then
	rm ./MatchedFilter/src/output.bin
fi

cmake -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build


if [ -e "./bin/matched_filter" ]; then
	echo "Launching the program..."
	./bin/matched_filter
	echo "********************************************"
	echo "** Computing cross correlation for signal **"
	echo "********************************************"

	
fi
