#include "matched_filtering.h"
#include <stdio.h>

__global__
void matchedFilter_kernel(float *signal, float *filter, float *output, int filterSize, int signalSize)
{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;
	int signalIdx = 512 + idx;
	int sum = 0;
	int index = 0;
	if (idx < (signalSize - filterSize + 1) && signalIdx < (signalSize - 512))
	{
		for(int i = (signalIdx - 512); i < (signalIdx + 512); i++)
		{
			sum += ( signal[i] * filter[index] );
			index++;
		}	
		output[idx] = sum;
	}
	__syncthreads();

}

void matchedFilter(float *signal, float *filter, float *output, int filterSize, int signalSize)
{
    	//@@ Allocate GPU memory here
	float *deviceSignal, *deviceFilter, *deviceOutput;

	int numBlocks = ( (signalSize - filterSize + 1) + BLOCK_SIZE - 1) / BLOCK_SIZE;

	gpuErrchk( cudaMalloc((void **) &deviceSignal, signalSize * sizeof(float)) );
	gpuErrchk( cudaMalloc((void **) &deviceFilter, filterSize * sizeof(float)) );

	gpuErrchk( cudaMalloc((void **) &deviceOutput, (signalSize - filterSize + 1) * sizeof(float)) );

    	//@@ Copy memory to the GPU here
	gpuErrchk( cudaMemcpy(deviceSignal, signal, signalSize * sizeof(float), cudaMemcpyHostToDevice) );
	gpuErrchk( cudaMemcpy(deviceFilter, filter, filterSize * sizeof(float), cudaMemcpyHostToDevice) );

   	//@@ Initialize the grid and block dimensions here
	dim3 gridDim(numBlocks, 1, 1);
	dim3 blockDim(BLOCK_SIZE, 1, 1);

    	//@@ Launch the GPU Kernel here
   	matchedFilter_kernel<<<gridDim,blockDim>>>(deviceSignal, deviceFilter, deviceOutput, filterSize, signalSize);

	cudaDeviceSynchronize();	

	//@@ Copy the GPU memory back to the CPU here
	gpuErrchk( cudaMemcpy(output, deviceOutput, (signalSize - filterSize + 1) * sizeof(float), cudaMemcpyDeviceToHost) );

	//@@ Free the GPU memory here	
	cudaFree(deviceSignal);
	cudaFree(deviceFilter);
	cudaFree(deviceOutput);
}
