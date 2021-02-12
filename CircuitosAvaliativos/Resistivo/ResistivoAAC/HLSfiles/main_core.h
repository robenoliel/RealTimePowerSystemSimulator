#include "stdio.h"

#define N_LC 0				// defines the number of LC elements
#define I_SOURCES 0			// defines the number of current sources in the circuit
#define V_SOURCES 1             // defines the number of voltage sources in the circuit
#define NODES 3				// defines the maximum number of nodes in the circuit (except node 0)
#define N 4					// defines the matrix G order (N = NODES + V_SOURCES)


#define PI 3.141593

//it refers to the output address for the require information
#define A 0
#define B 1
#define C 2
#define D 0


typedef float MATRIX_G;

typedef float VECTOR_I;
typedef float VECTOR_V;

struct OUTPUT{
	int a;
	int b;
	int c;
	int d;
};

struct V_SOURCE{
	float dtheta;
	float amplitude;
	float phase;
	float DClevel;
};

struct I_SOURCE{
	unsigned char n_out;
	unsigned char n_in;
	float dtheta;
	float amplitude;
	float phase;
	float DClevel;

};

struct LC_ELEMENT{
	unsigned char type;
	unsigned char n_out;
	unsigned char n_in;
	float g;
	float Ih;
};
