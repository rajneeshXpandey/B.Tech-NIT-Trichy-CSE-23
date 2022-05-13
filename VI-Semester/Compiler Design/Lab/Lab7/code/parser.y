%{
#include<string.h> 
#include<stdio.h> int yylex(void);
int yyerror(const char *s);

struct node{
char value;
struct node *left, *right;
};

struct start_node{ char value;
struct node *left, *right; struct start_node *next;
};

struct label_list{ char value;
struct label_list* next;
};

struct dag_node{
 
char value; int index;
struct label_list *labels; struct dag_node *left, *right;
};

struct root_list{
struct dag_node* root; struct root_list* next;
};

struct three_address{ char operator; char operand1; char operand2; char lhs;
struct three_address* next;
};

struct node* make_node(char);
struct start_node* create_start_node();

struct start_node *start_ptr = NULL;
struct three_address *start_three_address_ptr = NULL; struct root_list *roots = NULL;

char label = 'A' - 1; int index = 0;

%}

%union{
char symbol;
struct node *sub_expr;
struct start_node *start_expr;
}


%left '+' '-'
%left '/' '*'


%token <symbol> LETTER NUMBER
%type <sub_expr> exp
%type <sub_expr> L
%type <start_expr> stmts
%type <start_expr> statement


%start S

%%

S: stmts {
start_ptr = $1;
};

stmts: statement stmts {
struct start_node* curr = $1;
}

| statement {
    $$ =$1;
    $$ = curr;
};

 
statement: L '=' exp ';' {
 

struct start_node *curr = create_start_node(); curr->left = $1;
curr->right = $3;
$$ = curr;
};
 


exp: exp '+' exp { struct node* curr = make_node('+'); curr->left = $1;
curr->right = $3;
$$ = curr;
}

|exp '-' exp { struct node* curr = make_node('-');
curr->left = $1; curr->right = $3;
$$ = curr;
}
|exp '/' exp { struct node* curr = make_node('/');
curr->left = $1; curr->right = $3;
$$ = curr;
}

 
|exp '*' exp {
struct node *curr = make_node('*');
curr->left = $1;
curr->right = $3;
$$ = curr;
}
| '(' exp ')' {$$ = $2;}

|NUMBER {
    struct node* curr = make_node((char)$1);
    $$ = curr;
}

|LETTER {
struct node* curr = make_node((char)$1);
$$ = curr;
}
;

L: LETTER {
struct node* curr = make_node((char)$1);
$$ = curr;
};

%%


int yyerror(const char *s){
 
printf("%s",s);
}

struct start_node *create_start_node(){
struct start_node *temp_node = (struct start_node*)malloc( sizeof(struct start_node) );
temp_node->value = '=';
temp_node->left = temp_node->right = NULL; temp_node->next = NULL;
return temp_node;

}

struct node* make_node(char s){
struct node* temp_node = (struct node*)malloc(sizeof(struct node)); temp_node->left = NULL;
temp_node->right = NULL; temp_node->value = s; return temp_node;
}

struct three_address* add_to_end(struct three_address* start, struct three_address* curr){
if(start == NULL){ return curr;
}
struct three_address* temp = start; while(temp-> next != NULL){
temp = temp->next;
}
temp->next = curr; return start;
}

struct three_address* make_three_address_node(char lhs, char op, char op1, char op2){

struct three_address* temp_node = (struct three_address*)malloc(sizeof(struct three_address));
temp_node->lhs = lhs; temp_node->operator = op; temp_node->operand1 = op1; if(op != '='){
temp_node->operand2 = op2;
}
temp_node->next = NULL; return temp_node;
}

char postfix(struct node* curr){


if(curr->left == NULL && curr->right == NULL){ return curr->value;
}

char lhs = postfix(curr->left); char rhs = postfix(curr->right); char curr_char = ++label;
 
struct three_address *temp_node = make_three_address_node(curr_char, curr-
>value, lhs, rhs);
start_three_address_ptr = add_to_end(start_three_address_ptr, temp_node);

return curr_char;
}

void traverse(struct start_node *curr){ if(curr==NULL){
return;
}

char lhs = postfix(curr->left); char rhs = postfix(curr->right);

struct three_address *temp_node = make_three_address_node(lhs, '=', rhs, ' '); start_three_address_ptr = add_to_end(start_three_address_ptr, temp_node);

traverse(curr->next);
}

void print_three_addr(){
struct three_address* temp = start_three_address_ptr; while(temp){
if(temp->operator == '='){
printf("%c %c %c\n", temp->lhs, temp->operator, temp->operand1);
}
else{
printf("%c = %c %c %c\n", temp->lhs, temp->operand1, temp->operator, temp->operand2);
}
temp = temp->next;
}
}

struct label_list* insert_label(struct label_list* curr, char c){ struct label_list* temp = (struct label_list*)malloc(sizeof(struct
label_list));
temp->value = c; if(curr == NULL){
return temp;
}

struct label_list* t = curr; while(t->next != NULL){
t = t->next;
}
t->next = temp; return t;
}

struct dag_node* search_value(char value){ struct start = roots;
while(start){

}
}
 
struct dag_node* create_dag_node(char op, char res){
struct dag_node* temp = (struct dag_node*)malloc(sizeof(struct dag_node)); temp->labels = NULL;
temp->left = temp->right = NULL;
temp->labels = insert_label(temp->labels, res); temp->index = index++;
temp->value = op; return temp;
}

void create_dag(struct three_address* curr){ if(roots == NULL){
struct dag_node* curr = create_dag_node(curr->operator, curr->lhs); struct dag_node* left = create_dag_node(curr->operand1, ' '); struct dag_node* right = create_dag_node(curr->operand2, ' '); roots = curr;
}
else{
if(curr->operator == '='){
struct dag_node *temp = search_value(curr->operand1); temp->labels = insert_label(temp->labels, curr->lhs);
}
else{
struct dag_node *temp
}
}

create_dag(curr->next);
}


int main(){
printf("Enter the expression: "); yyparse();
traverse(start_ptr); print_three_addr(); printf("\n"); return 0;
}
