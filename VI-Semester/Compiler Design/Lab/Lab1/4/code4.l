%{
#include<stdio.h>
%}



%%

b*aa*ba*b(a|b)* printf("Not Accepted") ;
[\^b*aa*ba*b(a|b)*]+   printf("Accepted") ;

%%

int yywrap()
{
return 1;
}  

int main()
{
   printf("Enter String\n");
   // called yylex
   yylex();
return 0;
}