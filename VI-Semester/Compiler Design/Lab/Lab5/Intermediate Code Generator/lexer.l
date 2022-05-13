%{
#include"parser.tab.h"
%}

%%
[\t ] ;
[0-9]+ {yylval.symbol = (char)(yytext[0]);return NUMBER;}
[a-z] {yylval.symbol = (char)(yytext[0]);return LETTER;}
">=" {return GE;}
"<=" {return LE;}
"==" {return EQ;}
"!=" {return NE;}
"&&" {return AND;}
"||" {return OR;}
. {return yytext[0];}
\n {return 0;}
%%

int yywrap(){
    return 1;
}