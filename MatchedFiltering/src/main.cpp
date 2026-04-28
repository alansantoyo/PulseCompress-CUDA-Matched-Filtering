#include "matched_filtering.h"
#include <fstream>

int main(int argc, char **argv)
{
	
	float *data = new float[SIG_SIZE];
	std::ifstream file("/home/axs4549/PulseCompress-CUDA-Matched-Filtering/MatchedFiltering/src/signal.bin", std::ios::binary);
	if (!file.is_open())
	{
		std::cout << "ERROR: Signal file could not be opened.\n\n";
		return -1;
	}
	file.read(reinterpret_cast<char*>(data), 50000000 * sizeof(float));
	
	// Read the signal file -- done
	// Read the filter file -- done 
	float *filter = new float[FILTER_SIZE];
	std::ifstream file1("/home/axs4549/PulseCompress-CUDA-Matched-Filtering/MatchedFiltering/src/filter.bin", std::ios::binary);
	if (!file1.is_open())
	{
		std::cout << "ERROR: Filter file could not be opened.\n\n";
		return -1;
	}
	file1.read(reinterpret_cast<char*>(filter), 1024 * sizeof(float));

	float *result = new float[SIZE_SIZE + FILTER_SIZE - 1];

	// allocated memory for result -- done
	//
	// Next, call the function.

	matchedFilter(data, filter, result, FILTER_SIZE, SIG_SIZE);

	// After I have the result, make a binary file, and display it using either matlab or python
	






	return 0;
}
