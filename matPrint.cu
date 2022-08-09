#include "matPrint.h"
#include "config.h"



void matPrint(int* mat ,int rows,int cols){
for (int i=0;i<rows;i++){
	for (int j=0;j<cols;j++){
	
		printf("%d\t",*(mat + i*cols + j));
		if (cols-1 == j) printf("\n\n");
	}
}
}
