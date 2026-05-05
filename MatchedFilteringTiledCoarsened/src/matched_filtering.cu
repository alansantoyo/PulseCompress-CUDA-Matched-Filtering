#include "matched_filtering.h"
#include <stdio.h>

__constant__ float MF_filter[1024];

__global__
void matchedFilter_kernel(float *signal, float *filter, float *output, int filterSize, int signalSize)
{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;
	float sum = 0.0f;
	float sum2 = 0.0f;
	__shared__ float s_signal[1535];	

	int spot_in_signal = blockIdx.x * blockDim.x;
	int tileSize = (blockDim.x * 2) + 1023;	
	for(int i = threadIdx.x; i < tileSize; i = i + blockDim.x) 
	{
		int global_idx = spot_in_signal + i;
		if(global_idx < signalSize) 
		{
			s_signal[i] = signal[global_idx];
		}
		else
		{
			s_signal[i] = 0.0f;
		}
	}
	__syncthreads();
	
	
	if ((idx * 2) < (signalSize - filterSize + 1) )
	{
		for(int i = 0; i < filterSize; i++) // For coarsening, I want to calculate two values at once.
		{
			sum += ( s_signal[(threadIdx.x * 2) + i] * MF_filter[i] );
			sum2 += (s_signal[((threadIdx.x * 2)+1) + i] * MF_filter[i] );
		}	
		output[idx * 2] = sum;
	}
	if( ((idx * 2) + 1) < (signalSize - filterSize + 1) )
		output[(idx * 2) + 1] = sum2;
	

	__syncthreads();

}

void matchedFilter(float *signal, float *filter, float *output, int filterSize, int signalSize)
{
    	//@@ Allocate GPU memory here
	float *deviceSignal, *deviceOutput; // Deleted deviceFilter because of the global filter

	int numBlocks = (( (signalSize - filterSize + 1) + BLOCK_SIZE - 1) / BLOCK_SIZE) / 2;

	gpuErrchk( cudaMalloc((void **) &deviceSignal, signalSize * sizeof(float)) );
	gpuErrchk( cudaMalloc((void **) &deviceOutput, (signalSize - filterSize + 1) * sizeof(float)) );

    	//@@ Copy memory to the GPU here
	gpuErrchk( cudaMemcpy(deviceSignal, signal, signalSize * sizeof(float), cudaMemcpyHostToDevice) );

	gpuErrchk( cudaMemcpyToSymbol(MF_filter, filter, filterSize * sizeof(float)) );
   	//@@ Initialize the grid and block dimensions here
	dim3 gridDim(numBlocks, 1, 1);
	dim3 blockDim(BLOCK_SIZE, 1, 1);

    	//@@ Launch the GPU Kernel here
   	matchedFilter_kernel<<<gridDim,blockDim>>>(deviceSignal, nullptr, deviceOutput, filterSize, signalSize);

	cudaDeviceSynchronize();	

	//@@ Copy the GPU memory back to the CPU here
	gpuErrchk( cudaMemcpy(output, deviceOutput, (signalSize - filterSize + 1) * sizeof(float), cudaMemcpyDeviceToHost) );

	//@@ Free the GPU memory here	
	cudaFree(deviceSignal);
	cudaFree(deviceOutput);
}
