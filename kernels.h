#ifndef ker_H
#define ker_H
int ker_identity[9] = { 0, 0, 0,	\
			0, 1, 0,	\
			0, 0, 0		};

int ker_sobel[9] = {	-1, 0, 1,	\
			-2, 0, 2,	\
			-1, 0, 1	};

int ker_ridge4[9] = {	-1, -1, -1,	\
			-1,  4, -1,	\
			-1, -1, -1	};

int ker_ridge8[9] = {	-1, -1, -1,	\
			-1,  8, -1,	\
			-1, -1, -1	};
#endif /* ker_h*/
