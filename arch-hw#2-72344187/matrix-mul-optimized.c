#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define N 10000 

void init_matrix(double *mat, int n) {
    for (int i = 0; i < n * n; i++) {
        mat[i] = (double)(i % 100); 
    }
}

void multiply(double *A, double *B, double *C, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            double sum = 0.0;
            for (int k = 0; k < n; k++) {
                sum += A[i * n + k] * B[k * n + j];
            }
            C[i * n + j] = sum;
        }
    }
}


int main() {
    printf("Matrix size: %d x %d\n", N, N);

    size_t bytes = sizeof(double) * N * N;
    double *A = (double *)malloc(bytes);
    double *B = (double *)malloc(bytes);
    double *C = (double *)malloc(bytes);

    if (!A || !B || !C) {
        fprintf(stderr, "Memory allocation failed!\n");
        return 1;
    }

    init_matrix(A, N);
    init_matrix(B, N);
    memset(C, 0, bytes);

    clock_t start = clock();
    multiply(A, B, C, N);
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;

    printf("Total memory used: %.2f MB\n", 3 * bytes / (1024.0 * 1024.0));
    printf("Time taken for multiplication: %.6f seconds\n", elapsed);

    free(A);
    free(B);
    free(C);
    return 0;
}
