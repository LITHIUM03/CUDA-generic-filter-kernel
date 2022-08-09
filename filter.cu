#include "config.h"
#include "filter.h"

/* all sizes are defined in config to avoid unneeded copying. src and dst are ROWS X COLS matrices. fil is F_COLS X F_COLS matrix. F_DIM = F_COLS^2.
 * each block writes a specific element of the dst matrix, namely dst[blockIdx.x][blockIdx.y]
 * BLACK_MARGIN is the number of rows / cols of the dst matrix that are not affected by the filter. those areas are zeroed.
 * BLACK_MARGIN is defind as F_COLS/2 (floor division). for a 3X3 like sobel this number is 3.
 */

__global__ void applyFilter(int* src, int* fil, int* dst)
{      
	int dst_idx = blockIdx.y /*how many rows of blocks to skip*/ * gridDim.x \
		      /*how many block are there in a row*/ + blockIdx.x /* inner row offset*/;
	
	if ((blockIdx.x < BLACK_MARGIN ||blockIdx.x > COLS-1 - BLACK_MARGIN)||
		(blockIdx.y < BLACK_MARGIN ||blockIdx.y > ROWS-1 - BLACK_MARGIN)){
//		printf(" I am now painting black pixel at [%d, %d]\n",blockIdx.x,blockIdx.y);
		dst[dst_idx] = 0 ;
		return;
	}

	__shared__ int cache;
	if(0 == threadIdx.x && 0 == threadIdx.y)
		cache = 0;
	__syncthreads();
	//dst_idx is the index in the filter with which the thread will multiply.
	int t_idx = threadIdx.y*blockDim.x + threadIdx.x;
	
	//srd_idx is the index in the input array to which the thread will write.
	int src_idx = ((threadIdx.y-(F_COLS/2))+blockIdx.y) * COLS + ((threadIdx.x-(F_COLS/2))+blockIdx.x);

	atomicAdd(&cache,fil[t_idx] * src[src_idx]);
	
	__syncthreads();

	if(!(threadIdx.x-F_COLS/2) && !(threadIdx.y-F_COLS/2))
	dst[src_idx] = cache;
}

