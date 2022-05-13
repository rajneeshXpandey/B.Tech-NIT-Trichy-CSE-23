#include <stdio.h>
int main() {
    float num1;
    float num2;
    float product;
    float sum;
    printf("Enter two numbers: ");
    scanf("%lf %lf", &num1, &num2);  
 
    // Calculating product
    product = num1*num2;
    // Calculating sum
    sum = num1 + num2;
    // %.2lf displays number up to 2 decimal point
    printf("Product = %.2lf", product);
    printf("Sum = %.2lf", sum);
    return 0;
}