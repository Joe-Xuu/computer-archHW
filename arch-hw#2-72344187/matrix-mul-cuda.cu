#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <cublas_v2.h>
#include <chrono>

#define N 10000  // matrix size

void checkCuda(cudaError_t result, const char *msg) {
    if (result != cudaSuccess) {
        fprintf(stderr, "%s: %s\n", msg, cudaGetErrorString(result));
        exit(1);
    }
}

void checkCublas(cublasStatus_t status, const char *msg) {
    if (status != CUBLAS_STATUS_SUCCESS) {
        fprintf(stderr, "%s: cuBLAS error code %d\n", msg, status);
        exit(1);
    }
}

int main() {
    double *A, *B, *C;
    double *d_A, *d_B, *d_C;
    size_t size = N * N * sizeof(double);

    // Host memory allocation
    A = (double*)malloc(size);
    B = (double*)malloc(size);
    C = (double*)malloc(size);

    // Initialize A and B with some values
    for (int i = 0; i < N * N; i++) {
        A[i] = 1.0;  // or any function
        B[i] = 2.0;
    }

    // Device memory allocation
    checkCuda(cudaMalloc((void**)&d_A, size), "cudaMalloc A");
    checkCuda(cudaMalloc((void**)&d_B, size), "cudaMalloc B");
    checkCuda(cudaMalloc((void**)&d_C, size), "cudaMalloc C");

    // Copy data to device
    checkCuda(cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice), "Memcpy A");
    checkCuda(cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice), "Memcpy B");

    // cuBLAS handle
    cublasHandle_t handle;
    checkCublas(cublasCreate(&handle), "Create cuBLAS handle");

    // Start timing
    auto start = std::chrono::high_resolution_clock::now();

    // Perform C = A * B
    const double alpha = 1.0;
    const double beta = 0.0;
    checkCublas(
        cublasDgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N,
                    N, N, N,
                    &alpha,
                    d_B, N,
                    d_A, N,
                    &beta,
                    d_C, N),
        "cuBLAS DGEMM");

    // Stop timing
    checkCuda(cudaDeviceSynchronize(), "Device sync");
    auto stop = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> duration = stop - start;

    // Copy result back
    checkCuda(cudaMemcpy(C, d_C, size, cudaMemcpyDeviceToHost), "Memcpy C");

    // Print time
    printf("Matrix multiplication using cuBLAS (size %d x %d)\n", N, N);
    printf("Time taken: %.6f seconds\n", duration.count());

    // Free memory
    cublasDestroy(handle);
    cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
    free(A); free(B); free(C);

    return 0;
}
