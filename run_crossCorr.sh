#!/bin/bash
#SBATCH --export=/usr/local/cuda/bin
#SBATCH --gres=gpu:1

if [ -f "./MatchedFilter/src/output.bin" ]; then
	rm ./MatchedFilter/src/output.bin
fi
if [ -e "./MatchedFilterTiled/src/output.bin" ]; then
	rm ./MatchedFilterTiled/src/output.bin
fi

cmake -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build


if [ -e "./bin/matched_filter" ]; then
	echo "Launching the unoptimized kernel..."
	./bin/matched_filter
	echo "Unoptimized kernel finished."
fi

if [ -e "./bin/matched_filter_tiled" ]; then
	echo "Launching kernel with tiling..."
	./bin/matched_filter_tiled
	echo "Tiled kernel finished."
fi
