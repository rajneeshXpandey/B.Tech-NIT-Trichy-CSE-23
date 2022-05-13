%{
#include<stdio.h>
%}


%%

\#.*\n ;
"++"|"--" printf("Unary and Postfix ");ECHO;printf("\n");
"+"|"-"    printf("Unary and Additive ");ECHO;printf("\n");
"!"|"~"|"sizeof()" printf("Unary ");ECHO;printf("\n");
"*"|"/"|"%"  printf("Multiplicative ");ECHO;printf("\n");
"<<"|">>" printf("Shift ");ECHO;printf("\n");
"<"|"<="|">"|">=" printf("Relational ");ECHO;printf("\n");
"=="|"!=" printf("Equality ");ECHO;printf("\n");
"&" printf("Bitwise AND ");ECHO;printf("\n");
"|" printf("Bitwise OR ");ECHO;printf("\n");
"^" printf("Bitwise XOR ");ECHO;printf("\n");
"&&" printf("Logical AND ");ECHO;printf("\n");
"||" printf("Logical OR ");ECHO;printf("\n");
"?:" printf("Conditional ");ECHO;printf("\n");
"="|"+="|"-="|"*="|"/="|"%="|">>="|"<<="|"&="|"^="|"|=" printf("Assignment ");ECHO;printf("\n");
"," printf("Comma ");ECHO;printf("\n");
\".*\" ;
\n ;
. ;  

%%

int yywrap()
{
return 1;
}  

int main()
{
   yyin = fopen("input3.c", "r");
   yylex();
   return 0;
}