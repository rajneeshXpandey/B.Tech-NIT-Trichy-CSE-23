%{
#include<stdio.h>
//#include<string.h>
%}
  
%%
  
"float" fprintf(yyout,"double");
.|\n fprintf(yyout,"%s",yytext);

%%
  
int yywrap()
{
    return 1;
}
  

int main()
{
  yyin = fopen("input5.c", "r");
    yyout = fopen("output5.c", "w");
  
    yylex();
    return 0;
}