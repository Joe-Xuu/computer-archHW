Computer Architecture HW #4
Basics of floating point numbers

Name: Xu Haoran  Student ID: 72344187

This program determines the smallest and largest "float" & "double" type my computer can handle 
by dividing 1.0 by 2.0 / mutiplying 1.0 by 2.0 repeatedly.

Environment: 
Machine Type: x86_64
Operating System: Microsoft Windows 11 Professional 10.0.26100 Build 26100
Compiler: gcc (GCC) 12.4.0
Compile command: gcc -O2 -o float-basic float-basic.c

Source code: float-basic.c

Excutable: float-basic.exe

Output: 
D:\keio\2025spring\arch\arch-hw#4-72344187> ./float-basic
Final float min before zero: 1.40129846432481707092372958328991613128026194187652e-45
Float min iterations: 149

Final float max before inf: 1.70141183460469231731687303715884105728000000000000e+38
float max iterations: 127

Final double min before zero: 4.94065645841246544176568792868221372365059802614325e-324
double min iterations: 1074

Final double max before inf: 8.98846567431157953864652595394512366808988489471153e+307
double max iterations: 1023
