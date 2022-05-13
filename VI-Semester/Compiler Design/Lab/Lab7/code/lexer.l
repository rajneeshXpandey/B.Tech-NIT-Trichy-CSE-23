%{
    #include"parser.tab.h"
%}
%%
[\t ] ;
[0-9]+ {yylval.symbol = (char)(yytext[0]);return NUMBER;}
[a-z] {yylval.symbol = (char)(yytext[0]);return LETTER;}
. {return yytext[0];}
\n\n {return 0;}
%%
int yywrap(){
    return 1;
}
