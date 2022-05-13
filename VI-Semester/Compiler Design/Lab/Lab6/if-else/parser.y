%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
void push();
void pusha();
void pushab();
void abc();
void abcde();
void second();
void second1();
void first();
void third();
void codegen();
void codegen_umin();
void codegen_assigna();
void codegen_assign();
void codegen_assignb();
void lab();
void lab1();
void lab2();
void lab3();

%}

%token ID NUM IF THEN ELSE
%right '=' 
%left '+' '-'
%left '*' '/'
%left UMINUS
%%

S : IF '(' Y ')'{lab();} THEN '{' X '}'{lab2();} ELSE '{' X '}' {lab3();}
  ;
X : E ';'|X X;
Y : B {abc();codegen_assigna();first();}
  | B '&''&'{abc();codegen_assigna();second();} Y
  | B {abc();codegen_assigna();third();}'|''|' Y
  | '!'B{abcde();codegen_assigna();first();}
  ;

B : V '='{push();}'='{push();}D
  | V '>'{push();}F
  | V '<'{push();}F
  | V '!'{push();}'='{push();}D
  |'(' B ')'
  | V{pushab();}
  
;
F :'='{push();}D
  |D{pusha();}
;
D :NUM{push();}
  |ID{push();}
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
  | S
;
V : ID {push();}
  ;
%%

#include "lex.yy.c"
#include<ctype.h>
char st[100][10];
int top=0;
char i_[2]="0";
char temp[2]="t";
int abcd=0;
int label[20];
int lnum=0;
int ltop=0;
int i=0;
int main()
 {
 printf("Enter the expression : ");
 yyparse();
 }

int yywrap(){return(1);}

void pusha()
{
strcpy(st[++top]," " );
}
void pushab()
{
strcpy(st[++top]," ");
strcpy(st[++top]," ");
strcpy(st[++top]," ");
}
void push()
 {
  strcpy(st[++top],yytext);
 }

void abc()
{
abcd++;
printf("\nX%d : if ",abcd);
}
void abcde()
{
abcd++;
printf("\nX%d :not ",abcd);
}
void second1()
{
printf("\nif x%d true goto L%d\n",abcd,lnum);
printf("\nif x%d false goto L%d\n",abcd,++lnum);
lnum=lnum-1;
}
void second()
{
int xyz=0;
xyz=abcd+1;
printf("falg=true else flag=false");
printf("\n if flag(true) goto x%d",xyz);
printf("\n if flag(false) goto L1");
}
void first()
{
printf("flag=true else flag=false");
printf("\n if flag(true) goto  L0");
printf("\n if flag(false) goto L1");
}
void third()
{
int xyz=0;
xyz=abcd+1;
printf("flag=true else flag=false");
printf("\n if flag(true) goto L0 ");
printf("\n if flag(false) goto x%d",xyz);
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

void codegen_assigna()
{
printf("%s %s %s %s ",st[top-3],st[top-2],st[top-1],st[top]);
top-=3;
}
void codegen_assign()
 {
 printf("%s = %s\n",st[top-2],st[top]);
 top-=2;
 }
void codegen_assignb()
{
printf("%s %s %s ",st[top-3],st[top-2],st[top-1]);
top-=3;
}

void lab()
{
printf("\nL0 :\n");
}
void lab1()
{
 strcpy(temp,"t");
 strcat(temp,i_);
 printf("\n%s = not arguement \n",temp);
 printf("if %s goto L%d\n",temp,lnum);
 i_[0]++;
 label[++ltop]=lnum;
}

void lab2()
{
int x;
lnum++;
x=label[ltop--];
printf("goto L2\n");
printf("L%d: \n",++x);
label[++ltop]=lnum;
}

void lab3()
{
int y;
y=label[ltop--];
printf("L2: \n");
}