// Computer Architecture HW #4
// Basics of floating point numbers
// Name: Xu Haoran  Student ID: 72344187
/* 
    This program determines the smallest and largest 
    "float" & "double" type my computer can handle by
    dividing 1.0 by 2.0 repeatedly.
*/

#include <stdio.h>
#include <math.h> // for isinf

int main(){
    float a = 1.0;
    int float_small_iter = 0; 
    while (a/2.0f > 0.0f) {
        a /= 2.0f; // Divide by 2.0 repeatedly
        float_small_iter++;
    }
    printf("Final float min before zero: %.50e\n", a); // uses scientific notation for better precision
    printf("Float min iterations: %d\n\n", float_small_iter);

    a = 1.0;
    int float_large_iter = 0;
    while (!isinf(a*2.0f)) {
        a *= 2.0f; // Multiply by 2.0 repeatedly
        float_large_iter++;
    }

    printf("Final float max before inf: %.50e\n", a);
    printf("float max iterations: %d\n\n", float_large_iter);

    double b = 1.0;
    int double_small_iter = 0;
    while (b/2.0f > 0.0f) {
        b /= 2.0;
        double_small_iter++;
    }

    printf("Final double min before zero: %.50e\n", b);
    printf("double min iterations: %d\n\n", double_small_iter);

    b= 1.0;
    int double_large_iter = 0;
    while (!isinf(b*2.0f)) {
        b *= 2.0;
        double_large_iter++;
    }

    printf("Final double max before inf: %.50e\n", b);
    printf("double max iterations: %d\n\n", double_large_iter);

    return 0;
}