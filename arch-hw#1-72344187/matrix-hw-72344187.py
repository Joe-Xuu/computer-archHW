# Name: Xu Haoran  Student ID: 72344187  python 3.11.9

def matrix_multiply(A, B):
    N = len(A)
    # initialize an NxN result matrix
    C = [[0.0 for _ in range(N)] for _ in range(N)]
    for i in range(N):
        for j in range(N):
            for k in range(N):
                C[i][j] += A[i][k] * B[k][j]
    return C

# multiply A and B matrices from the problem
A = [
    [1, 0, 3.14, 2.72],
    [2.72, 1, 0, 3.14],
    [1, 1, 1, 1],
    [1, 2, 3, 4]
]

B = [
    [1, 1, 0, 3.14],
    [0, 1, 3.14, 2.72],
    [0, 1, 1, 0],
    [4, 3, 2, 1]
]

C = matrix_multiply(A, B)
for row in C:
    print(row)

# output
# [11.88, 12.3, 8.58, 5.86]
# [15.280000000000001, 13.14, 9.42, 14.400800000000002]
# [5.0, 6.0, 6.140000000000001, 6.86]
# [17.0, 18.0, 17.28, 12.58]