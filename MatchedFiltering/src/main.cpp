#include "matched_filtering.h"
#include <fstream>

int main(int argc, char **argv)
{
	
	float *data = new float[50000000];
	std::ifstream file("/home/axs4549/PulseCompress-CUDA-Matched-Filtering/MatchedFiltering/src/signal.bin", std::ios::binary);
	if (!file.is_open())
	{
		std::cout << "ERROR: Signal file could not be opened.\n\n";
		return -1;
	}
	file.read(reinterpret_cast<char*>(data), 50000000 * sizeof(float));
	
	// Read the signal file -- done
	// Read the filter file 
	float *filter = new float[1024];
	std::ifstream file1("/home/axs4549/PulseCompress-CUDA-Matched-Filtering/MatchedFiltering/src/filter.bin", std::ios::binary);
	if (!file1.is_open())
	{
		std::cout << "ERROR: Filter file could not be opened.\n\n";
		return -1;
	}
	file1.read(reinterpret_cast<char*>(filter), 1024 * sizeof(float));






	return 0;
}
