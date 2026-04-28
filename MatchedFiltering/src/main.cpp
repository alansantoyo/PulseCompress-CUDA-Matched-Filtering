#include "matched_filtering.h"
#include <fstream>

int main(int argc, char **argv)
{
	
	std::vector<float> data(50000000);
	std::ifstream file("/home/axs4549/PulseCompress-CUDA-Matched-Filtering/MatchedFiltering/src/signal.bin", std::ios::binary);
	if (!file.is_open())
	{
		std::cout << "ERROR: j \n\n";
		return -1;
	}
	file.read(reinterpret_cast<char*>(data.data()), 50000000 * sizeof(float));
	
	for( int i = 0; i < 30; i++)
		std::cout << data[i] << std::endl;







	return 0;
}
