%{
#include<stdio.h>
%}


%%
[a-z]+        {printf("%s small letters\n",yytext);}
[A-Z]+        {ECHO; printf("Capital letters\n");}
[0-9]*[.][0-9]+    {ECHO; printf("Decimal\n");}
[0-9]+        {printf("%s is integer\n",yytext);}
[-+*/]        {printf("Operators\n");}


%%
int yywrap(void){return 1;}

int main()
{
    yylex();
    return 0;
}