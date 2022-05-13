flex lexer.l
bison -vd parser.y
gcc lex.yy.c parser.tab.c -lm
./a.exe<input.c
./a.exe<input1.c