#ifndef _MATCHED_FILTERING_H_
#define _MATCHED_FILTERING_H_

#include <iostream>
#include <vector>
#include <cuda_runtime.h>

#define BLOCK_SIZE 512 //@@ You can change this
#define SIG_SIZE 50000000
#define FILTER_SIZE 1024

#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort = true) {
    if (code != cudaSuccess) {
        std::cerr << "GPUassert: " << cudaGetErrorString(code) << " " << file << " " << line << std::endl;
        if (abort) exit(code);
    }
}



// Function declaration will go here once I figure it out
void matchedFilter(float *signal, float *filter, float *output, int filterSize, int signalSize);



#endif
