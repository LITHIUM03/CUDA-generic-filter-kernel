
#include "matrices.h"

void indices(int* mat){
	for(int i = 0; i<ROWS; i++){
		for(int j = 0; j<ROWS; j++){
			*(mat + i*COLS + j) = i*COLS + j;
		}

	}
}
void vertical_4row_stripes(int* mat){
	for(int i = 0; i<ROWS; i++){
		for(int j = 0; j<ROWS; j++){
			*(mat + i*COLS + j) = (3 == j%8 || 2 == j%8 || 0 == j%8|| 1 == j%8 ? 0 : 255);
		}

	}
}

void vertical_2row_stripes(int* mat){
	for(int i = 0; i<ROWS; i++){
		for(int j = 0; j<ROWS; j++){
			*(mat + i*COLS + j) =( 0 == j%4 ||1 == j%4 ? 0 : 255);
		}

	}
}

void vertical_1row_stripes(int* mat){
	for(int i = 0; i<ROWS; i++){
		for(int j = 0; j<ROWS; j++){
			*(mat + i*COLS + j) =( 0 == j%2?0:255);
		}

	}
}

void horizontal_4row_stripes(int* mat){
	for(int i = 0; i<ROWS; i++){
		for(int j = 0; j<ROWS; j++){
			*(mat + i*COLS + j) = ( (3 == i%8 || 2 == i%8 || 0 == i%8 || 1 == i%8 ) ? 0 : 255);
		}

	}
}

void horizontal_2row_stripes(int* mat){
	for(int i = 0; i<ROWS; i++){
		for(int j = 0; j<ROWS; j++){
			*(mat + i*COLS + j) = ((0 == i%4 || 1 == i%4) ? 0 : 255);
		}

	}
}
void horizontal_1row_stripes(int* mat){
	for(int i = 0; i<ROWS; i++){
		for(int j = 0; j<ROWS; j++){
			*(mat + i*COLS + j) =( 0 == i%2 ? 0 : 255);
		}

	}
}
