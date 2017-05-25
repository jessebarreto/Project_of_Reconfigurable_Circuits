
#include <stdio.h>
#include <stdlib.h>

#include "operators.h"

#define ITERATIONNUMBER 10000 /*100 milhoes de iteracoes  -*/

float calculaGanho(float covK, float covZ)
{
	return divisao(covK, soma(covZ, covK));
}

float calculaDistancia(float yUl,  float yIr,  float *xUl, float *xIr)
{
	return 0.0;
}

float calculaFusao(float ganho, float xUl, float xIr)
{
	return soma(xUl, mult(ganho, sub(xIr, xUl)));
}

float calculaCov(float ganho, float covK)
{
	return sub(covK, mult(ganho, covK));
}


int main()
{
	float covK = 0.02;
	float covZ = 0.52;
	float ganho;
	float xUl = 70.5;
	float xIr = 72.25;
	
	float xFusao = 0.0;
	float newXUl = 0.0;
	float newXIr = 0.0;
	
	int i;
	for (i = 0; i < ITERATIONNUMBER; i++)
	{
			newXUl = xUl + 0.5 * rand()/2147483647.0;
			newXIr = xIr + 1.0 * rand()/2147483647.0;
			ganho = calculaGanho(covK, covZ);
			covK = calculaCov(ganho, covK);
			xFusao = calculaFusao(ganho, newXUl, newXIr);
			/*printf("Current State: xUl=%.3f xIr=%.3f covK=%.3f covZ=%.3f ganho=%.3f xFus=%.3f\n", newXUl, newXIr, covK, covZ, ganho, xFusao);*/
	}

	return 0;
}

