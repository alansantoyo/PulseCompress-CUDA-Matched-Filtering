#include "matched_filtering.h"

int main(int argc, char **argv)
{
	float val;
	std::ifstream file("signal.bin", std::ios:binary);

	file.seekg(0, std::ios::end);
	std::streamsize size = file.tellg();
	file.seekg(0, std::ios::beg);
	
	std::vector<float> buffer(size / sizeof(float));
	file.read(reinterpret_cast<char*>(buffer.data()), size);

	for( int i = 0; i < 5; i++)
		std::cout << buffer[i] << endl;







	return 0;
}
