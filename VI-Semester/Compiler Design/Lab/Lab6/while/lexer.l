%{
#include"parser.tab.h"
%}
ALPHA [A-Za-z]
DIGIT [0-9]
%%
while                return WHILE;
{ALPHA}({ALPHA}|{DIGIT})*    return ID;
{DIGIT}+             {yylval=atoi(yytext); return NUM;}
[ \t]                 ;
\n                yyterminate();
.                 return yytext[0];
%%
