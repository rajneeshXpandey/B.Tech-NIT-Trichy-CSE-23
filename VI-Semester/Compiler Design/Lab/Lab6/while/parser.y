%{
#include "lex.yy.c"
#include<ctype.h>
#include <string.h>
int yylex();
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
void push();
void codegen()  ;
void codegen_umin();
void codegen_assign();
void lab1();
void lab2();
void lab3();
%}

%token ID NUM WHILE
%right '='
%left '+' '-'
%left '*' '/'
%left UMINUS
%%

S : WHILE{lab1();} '(' E ')'{lab2();} E ';'{lab3();}
  ;
E :V '='{push();} E{codegen_assign();}
  | E '+'{push();} E{codegen();}
  | E '-'{push();} E{codegen();}
  | E '*'{push();} E{codegen();}
  | E '/'{push();} E{codegen();}
  | '(' E ')'
  | '-'{push();} E{codegen_umin();} %prec UMINUS
  | V
  | NUM{push();}
  ;
V : ID {push();}
  ;
%%

char st[100][10];
int top=0;
char i_[2]="0";
char temp[2]="t";

int lnum=1;
int start=1;
int main()
 {
 printf("Enter the expression : ");
 yyparse();
 }

int yywrap(){
  return(1);
}

void push()
 {
  strcpy(st[++top],yytext);
 }

void codegen()
 {
 strcpy(temp,"t");
 strcat(temp,i_);
  printf("%s = %s %s %s\n",temp,st[top-2],st[top-1],st[top]);
  top-=2;
 strcpy(st[top],temp);
 i_[0]++;
 }

void codegen_umin()
 {
 strcpy(temp,"t");
 strcat(temp,i_);
 printf("%s = -%s\n",temp,st[top]);
 top--;
 strcpy(st[top],temp);
 i_[0]++;
 }

void codegen_assign()
 {
 printf("%s = %s\n",st[top-2],st[top]);
 top-=2;
 }



void lab1()
{
printf("L%d: \n",lnum++);
}


void lab2()
{
 strcpy(temp,"t");
 strcat(temp,i_);
 printf("%s = not %s\n",temp,st[top]);
 printf("if %s goto L%d\n",temp,lnum);
 i_[0]++;
 }

void lab3()
{
printf("goto L%d \n",start);
printf("L%d: \n",lnum);
}
