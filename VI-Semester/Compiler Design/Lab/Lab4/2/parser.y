%{
#include<stdio.h>
#include<stdlib.h>
int yylex(void);
int yyerror(const char *s);
int success = 1;
%}
%token ID NUM WHILE LE GE EQ NE OR AND
%right '='
%left OR AND
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'
%%
S : WHILE '(' E2 ')' DEF
 ;
DEF : '{' BODY '}'
 | E';'
 | S
 ;
BODY : BODY BODY
 | E ';'
 | S
 |
 ;
E : ID '=' E
 | E '+' E
 | E '-' E
 | E '*' E
 | E '/' E
 | E '<' E
 | E '>' E
 | E LE E
 | E GE E
 | E EQ E
 | E NE E
 | E OR E
 | E AND E
 | E '+' '+'
 | E '-' '-'
 | ID
 | NUM
 ;
E2 : E'<'E
 | E'>'E
 | E LE E
 | E GE E
 | E EQ E
 | E NE E
 | E OR E
 | E AND E
 ;
%%
int main (void)
{
yyparse();
if(success)
 printf("Result of input.............. \n");
    
printf("Parsing Successful....WHILE loop!\n");
return 0;
}
int yyerror(const char *msg)
{
printf("Parsing Failed\n");
 success = 0;
return 0;
}