%{
#include<stdio.h>
%}
 

%%


\/\/(.*)\n ;
\/\*[^*/]*\*\/\n ;
([\t]|" ")*\n+ {fprintf(yyout,"\n");} 
\t ;
" "+ {fprintf(yyout," ");}


%%


int yywrap(){return 1;}

 

int main(int k,char **argcv)
{
  yyin=fopen(argcv[1],"r");
  yyout=fopen("output1.c","w");
  yylex();
  return 0;
}

