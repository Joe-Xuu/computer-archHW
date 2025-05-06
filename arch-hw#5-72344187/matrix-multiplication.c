// Computer Architecture HW #2
// matrix multiplication
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
    init_matrices();

    // clock_t start = clock();
    // multiply_matrices();
    // clock_t end = clock();

    // double elapsed = (double)(end - start) / CLOCKS_PER_SEC;
    // printf("Time taken for multiplication: %.6f seconds\n\n", elapsed);

    //HW report

    //1. print the addresses
    printf("Address of A: %p\n", &A[0][0]);
    printf("Address of B: %p\n", &B[0][0]);
    printf("Address of C: %p\n", &C[0][0]);

    //2. print the size of a double floating point number
    double a = 0.0;
    printf("Size of double floating point#: %lu bytes\n\n", sizeof(a)); 

    //3. print the size of the matrix in bytes
    printf("Matrix size: %d x %d\n", SIZE, SIZE);
    size_t total_bytes = SIZE * SIZE * sizeof(double);
    printf("Total memory used: %.2ld Bytes\n\n", total_bytes);

    //4. print the addresses of elements of the matrix
    //row major: &array[i][j] = base_address + ((i * SIZE) + j) * sizeof(double)
    printf("A[0][0] = %p\n", &A[0][0]);
    printf("A[0][1] = %p\n", &A[0][1]);
    printf("A[0][SIZE-1] = %p\n", &A[0][SIZE-1]);
    printf("A[1][0] = %p\n", &A[1][0]);
    printf("A[SIZE-1][0] = %p\n", &A[SIZE-1][0]);
    printf("A[SIZE-1][1] = %p\n", &A[SIZE-1][1]);
    printf("A[SIZE-1][SIZE-1] = %p\n\n", &A[SIZE-1][SIZE-1]);

    printf("B[0][0] = %p\n", &B[0][0]);
    printf("B[0][1] = %p\n", &B[0][1]);
    printf("B[0][SIZE-1] = %p\n", &B[0][SIZE-1]);
    printf("B[1][0] = %p\n", &B[1][0]);
    printf("B[SIZE-1][0] = %p\n", &B[SIZE-1][0]);
    printf("B[SIZE-1][1] = %p\n", &B[SIZE-1][1]);
    printf("B[SIZE-1][SIZE-1] = %p\n\n", &B[SIZE-1][SIZE-1]);

    printf("C[0][0] = %p\n", &C[0][0]);
    printf("C[0][1] = %p\n", &C[0][1]);
    printf("C[0][SIZE-1] = %p\n", &C[0][SIZE-1]);
    printf("C[1][0] = %p\n", &C[1][0]);
    printf("C[SIZE-1][0] = %p\n", &C[SIZE-1][0]);
    printf("C[SIZE-1][1] = %p\n", &C[SIZE-1][1]);
    printf("C[SIZE-1][SIZE-1] = %p\n\n", &C[SIZE-1][SIZE-1]);

    return 0;
}

