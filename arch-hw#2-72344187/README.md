Computer Architecture HW #2
Matrix multiplication in C

Name: Xu Haoran 
Student ID: 72344187

The folder includes files below:

codes:
	matrix-multiplication.c  (the original single thread c program runs in container, works well for 10, 100, 1000 sizes)
	matrix-mul-optimized.c (c program using malloc, compiled on WSL with -o3 parameters)
	matrix-mul-cuda.cu (a cuda c program using GPU to do the multiplications)

executables:
	mat-mul-opt-fin (the executable file of matrix-mul-optimized.c)
	matrix-mul-cuda.exe (executable file of cuda c program)
	matrix-mul-10/100/1000 (executables of matrix-multiplication.c for 10/100/1000 matrices)

something else:
	matrix-mul-cuda.exp/matrix-mul-cuda.lib (something generated while compiling cuda c program)

proof it works:
	waiting-for-container.png
	waiting-for-WSL.png
	10-100-1000-in-container.png
	compiling-cuda.png
	cuda-works!.png

JSON of cl.exe for VS:
	.vscode/

Time for multiplying matrices & Matrix size: 

Matrix size: 10 x 10
Total memory used: 0.00 MB
Time taken for multiplication: 0.000007 seconds

Matrix size: 100 x 100
Total memory used: 0.23 MB
Time taken for multiplication: 0.006116 seconds

Matrix size: 1000 x 1000
Total memory used: 22.89 MB
Time taken for multiplication: 4.110167 seconds

Matrix size: 10000 x 10000
Total memory used: 2288.82 MB
Time taken for multiplication: (over 2 hours)

# D:\keio\2025spring\arch\arch-hw#2-72344187>matrix-mul-cuda.exe
# Matrix multiplication using cuBLAS (size 10000 x 10000)
# Time taken: 6.672001 seconds

Observations:
Runtime grows approx. cubically with matrix size. O(n³)
Memory usage grows approx. quadratically. O(n²)
The 10000 x 10000 case uses ~2.3 GB of RAM and has a really excessive runtime (I waited for approximately 2 hours).
While waiting for the 10000 x 10000 task to finish, I tried to compile and run it directly by  PC. 
However, the 10000x10000 double matrices I defined in the program take 800MB x 3 = 2.3GB, and they are global variables, which means they are static. 
The Cygwin's Windows linker couldn't deal with such a huge .data segment, therefore as a consequence, it caused relocation overflow.
So I used WSL instead of Cygwin, I rewrote the code with malloc, compiled again with -o3 parameter.
But after waiting for another 30 minutes, I decided to give up and try something faster.
I relized that I have a pretty powerful GPU (RTX4070), so I decided to try the CUDA C.
After half an hour of downloading and painful environment configuration, I refactored my previous program using CUDA C, and used CI to compile it.
Cuda really didn't let me down, it finished the task in only 6 seconds which single threaded cpu takes hours to run!