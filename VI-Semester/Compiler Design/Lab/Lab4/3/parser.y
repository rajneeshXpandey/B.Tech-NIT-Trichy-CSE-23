%{
#include<stdio.h>
void yyerror(const char *s);
int yylex();
%}

%token FOR ID NUMBER UNARY BINARY

%%

program: program loop body                    { printf("Loops and more? \n"); }
| loop body                                   { printf("Loops! \n"); }
;

loop: FOR '(' for_statements ')'              { printf("For loop! \n"); }
;

body: statement                               { printf("Nothin' much... \n"); }
| '{' statements '}'                          { printf("Code Block! \n"); }
| '{' loop '}' body                           { printf("Nested For? \n"); }
;

for_statements: statement ';' statement ';' statement
;

statements: statements statement ';'          { printf("Lecture begins! \n"); }
| statement ';'                               { printf("One liner! \n"); }
;

statement: ID BINARY statement
| ID UNARY
| UNARY ID
| ID
| NUMBER
;

%%

int main() {
    printf("Result of input.............. \n");
    yyparse();
}

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}