// HW #2 Matrix Multiplication
// Name: Xu Haoran  Student ID: 72344187
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 10000  // 10 100 1000 10000

double A[SIZE][SIZE];
double B[SIZE][SIZE];
double C[SIZE][SIZE];

void init_matrices() {
    for (int i = 0; i < SIZE; ++i)
        for (int j = 0; j < SIZE; ++j) {
            A[i][j] = (double)(i + j);
            B[i][j] = (double)(i - j);
            C[i][j] = 0.0;
        }
}

void multiply_matrices() {
    for (int i = 0; i < SIZE; ++i)
        for (int j = 0; j < SIZE; ++j)
            for (int k = 0; k < SIZE; ++k)
                C[i][j] += A[i][k] * B[k][j];
}

int main() {
    printf("Matrix size: %d x %d\n", SIZE, SIZE);
    size_t total_bytes = 3 * SIZE * SIZE * sizeof(double);
    printf("Total memory used: %.2f MB\n", total_bytes / (1024.0 * 1024.0));

    init_matrices();

    clock_t start = clock();
    multiply_matrices();
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Time taken for multiplication: %.6f seconds\n", elapsed);

    return 0;
}

