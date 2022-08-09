/*
 * Copyright 1993-2015 NVIDIA Corporation.	All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * ! with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 *
 */
	

// System includes
#include <stdio.h>
#include <assert.h>

// CUDA runtime
#include <cuda_runtime.h>

// helper functions and utilities to work with CUDA
#include <helper_functions.h>
#include <helper_cuda.h>
#include "matPrint.h"
#include "filter.h"
#include "config.h"

#ifndef MAX
#define MAX(a,b) (a > b ? a : b)
#endif


int main(int argc, char **argv)
{
	int devID;
	cudaDeviceProp props;

	// This will pick the best possible CUDA capable device
	devID = findCudaDevice(argc, (const char **)argv);

	//Get GPU information
	checkCudaErrors(cudaGetDevice(&devID));
	checkCudaErrors(cudaGetDeviceProperties(&props, devID));
	printf("Device %d: \"%s\" with Compute %d.%d capability\n",
	devID, props.name, props.major, props.minor);

	//Kernel configuration, where a two-dimensional grid and
	
	dim3 dimGrid(ROWS,COLS);// DO NOT TOUCH THIS!!!!!
	dim3 dimBlock(3,3);
	
	int *h_srcmat =(int*) malloc(sizeof(int)*DIM);
	int *h_dstmat =(int*) malloc(sizeof(int)*DIM);
	int* d_srcmat;
	int* d_dstmat;

	for(int i =0 ; i<ROWS;i++){
		for(int j=0 ; j<COLS;j++){
		*(h_srcmat + i*COLS + j) = i*COLS + j;
		}
	}
	printf("src matrix\n");
	matPrint(h_srcmat,ROWS,COLS);
	int h_f[F_DIM]={0};
	for (int i=0;i<F_DIM;i++)h_f[i]=1;
	//matPrint(h_f,F_COLS,F_COLS);
	cudaMalloc((void**)&d_srcmat,sizeof(int)*DIM);
	cudaMalloc((void**)&d_dstmat,sizeof(int)*DIM);
	
	int* d_f;	
	cudaMalloc((void**)&d_f,sizeof(int)*DIM);
	
	cudaMemcpy(d_srcmat,h_srcmat,sizeof(int)*DIM,cudaMemcpyHostToDevice);
	cudaMemcpy(d_f,h_f,sizeof(int)*F_DIM,cudaMemcpyHostToDevice);


	applyFilter<<<dimGrid, dimBlock>>>(d_srcmat,d_f,d_dstmat);

	cudaDeviceSynchronize();

	cudaMemcpy(h_dstmat,d_dstmat,sizeof(int)*DIM,cudaMemcpyDeviceToHost);
	printf("src matrix\n");
	matPrint(h_dstmat,ROWS,COLS);
	cudaFree(d_srcmat);
	cudaFree(d_dstmat);
	cudaFree(d_f);
	free(h_srcmat);
	free(h_dstmat);
	
	return EXIT_SUCCESS;
}

