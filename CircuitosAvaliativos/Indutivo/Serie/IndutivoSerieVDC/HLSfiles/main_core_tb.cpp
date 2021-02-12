#include "main_core.h"
#include <iostream>

OUTPUT nodalSolver(void);

int main(){
	OUTPUT outprint;

	FILE *fp;
	fp = fopen("C:\\Users\\rodrigobagdadi\\Desktop\\RealTime\\ProjetoPipelineHLS\\CircuitosAvaliativos\\Indutivo\\Serie\\IndutivoSerieVDC\\results_IndutivoSerieVDC.txt", "w");
	std::string perm;

	for(int i = 0; i < 99; i++){
		outprint = nodalSolver();

		perm.append(std::to_string(outprint.a));
		perm.append(" ");
		perm.append(std::to_string(outprint.b));
		perm.append(" ");
		perm.append(std::to_string(outprint.c));
		perm.append(" ");
		perm.append(std::to_string(outprint.d));
		perm.append(";");
	}
	fprintf(fp, perm.c_str());
	fclose(fp);
	return 0;
	
}
