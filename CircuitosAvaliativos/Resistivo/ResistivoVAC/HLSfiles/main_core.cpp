#include "hls_math.h"
#include "main_core.h"

static VECTOR_I G_vec_I[N];
static VECTOR_V G_vec_V[N];
// somente utilizar os reshapes abaixo com N <= 63
// quando N > 32, pode colocar clock baixo (10 ns) para uma latência total de 4*N*10 ns

void sinGen(void){
	#pragma HLS pipeline

	static I_SOURCE i_sources[I_SOURCES] = 
{};
	static V_SOURCE sources[V_SOURCES] = 
{{3.7699112e-02, 1.0000000e+01, 1.0471976e+00, 1.0000000e+01}};

	loop_1:for(unsigned char i = 0; i < V_SOURCES; i++){
		G_vec_I[i + NODES] = sources[i].DClevel + sources[i].amplitude*sin(sources[i].phase);

		if(sources[i].dtheta + sources[i].phase < 2*PI){
			sources[i].phase = sources[i].phase + sources[i].dtheta;
		}
		else{
			sources[i].phase = sources[i].phase + sources[i].dtheta - 2*PI;
		}
	}

	unsigned char k, m;
	loop_2:for(unsigned char j = 0; j < I_SOURCES; j++){
		k = i_sources[j].n_out;
		m = i_sources[j].n_in;

		if(k != 0){
			G_vec_I[k-1] -= i_sources[j].DClevel + i_sources[j].amplitude*sin(i_sources[j].phase);
		}
		if(m != 0){
			G_vec_I[m-1] += i_sources[j].DClevel + i_sources[j].amplitude*sin(i_sources[j].phase);
		}

		if(i_sources[j].dtheta + i_sources[j].phase < 2*PI){
			i_sources[j].phase = i_sources[j].phase + i_sources[j].dtheta;
		}
		else{
			i_sources[j].phase = i_sources[j].phase + i_sources[j].dtheta - 2*PI;
		}
	}
}

void vetmat(void){
	#pragma HLS pipeline
	// somente usar esta diretiva quando N <= 32.
	// nesta situação pode utilizar clock grande (300 ns) para solucionar em 1 único clock
	/*const MATRIX_G Gi [N][N] =  ;*/
	//#pragma HLS array_reshape variable=Gi complete dim=0
	const MATRIX_G Gi[N][N] = 
{{0.0000000e+00, 0.0000000e+00, 0.0000000e+00, 1.0000000e+00},
{0.0000000e+00, 2.5789923e+01, 8.7105038e+00, 8.7105038e-01},
{0.0000000e+00, 8.7105038e+00, 9.5644748e+00, 9.5644748e-01},
{1.0000000e+00, 8.7105038e-01, 9.5644748e-01, -4.3552519e-03}};
	float acc;
	loop_1:for(unsigned char i = 0; i<N; i++){
		acc = 0;
		loop_2:for(unsigned char j = 0; j<N; j++){
			acc += Gi[i][j]*G_vec_I[j];
			if(i == N-1){
				G_vec_I[j] = 0.0;
			}
		}
		G_vec_V[i] = acc;
	}
}

void histvect(void){
	#pragma HLS pipeline
	static LC_ELEMENT elements[N_LC] = 
{{0, 0, 2, 1.0000000e-02, 0.0000000e+00}};

	unsigned char k, m;
	float Vk, Vm;
	for(unsigned char i = 0; i < N_LC; i++){
		k = elements[i].n_out;
		m = elements[i].n_in;

		if(k == 0) Vk = 0.0;
		else Vk = G_vec_V[k-1];

		if(m == 0) Vm = 0.0;
		else Vm = G_vec_V[m-1];

		if(elements[i].type == 1){
			elements[i].Ih = -elements[i].Ih - elements[i].g*(Vk - Vm);
		}
		else{
			elements[i].Ih = elements[i].Ih + elements[i].g*(Vk - Vm);
		}

		if(k != 0) G_vec_I[k-1] -= elements[i].Ih;
		if(m != 0) G_vec_I[m-1] += elements[i].Ih;
	}
}
/*
int nearbyInt(float num){

	return nearbyint(num);
}*/

OUTPUT nodalSolver(void){
	//#pragma HLS PIPELINE II=90
	//#pragma HLS array_reshape variable=G_vec_V complete dim=0
	//#pragma HLS array_reshape variable=G_vec_I complete dim=0

	sinGen();
	vetmat();
	// export range: [-128.0, 128)
	OUTPUT out = {nearbyint(G_vec_V[A]*256 + 32768),
				  nearbyint(G_vec_V[B]*256 + 32768),
				  nearbyint(G_vec_V[C]*256 + 32768),
				  nearbyint(G_vec_V[D]*256 + 32768)};
	histvect();

	return out;
}


