// /* 106119100 - Rajneesh Pandey */

#include<stdio.h>
#include<string.h>

int main() {
    int x=1;
    float f;
    int a=3;
    int x;
    a = x * 3 + 1*a;
    if(x<a) {
        printf("Hi Rajneesh!");
        a = x * 3 + 100*a;
        if(x<a) {
            printf("Hi Rajneesh!");
            a = x * 3 + 100*a;
        }
        else {
            x = a * 3 + 100*a;
        }
    }
    else {
        x = a * 3 + 100*a;
    }
}