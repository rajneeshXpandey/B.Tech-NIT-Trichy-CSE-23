#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


char  keywords[22][10] = {"if","else","while","do","break","continue","int","double","float","return","char", "case", "sizeof", "long", "short","typedef","switch","unsigned","void", "static", "struct", "goto"};

// Parsing the input STRING.
void parse(char* str)
{
    int left = 0, right = 0;
    int len = strlen(str);

    //delimitors
    char delimiter[] = {" +-*/,;><=()[]{}\n\""};
    char operators[] = {"+-*/><=&"};
    int operlen = strlen(operators);
    int dellen = strlen(delimiter);
    while (right <= len && left <= right) {
        if(str[left] == '/' && str[left + 1] == '/'){
          break;
        }
        // check for string right to be delimiter
        bool isEndDel = false;
        for(int i=0;i<dellen;i++){
            if(delimiter[i] == str[right]){
                isEndDel = true;
                break;
            }
        }
        if(isEndDel == false)
            right++;
        isEndDel = false;
        for(int i=0;i<dellen;i++){
            if(delimiter[i] == str[right]){
                isEndDel = true;
                break;
            }
        }
        if (str[left] == '\"') {
          if(left == right)
          right++;
          while (str[right] != '\"') {
            right++;
          }
          right++;
          char* word = (char *) malloc((right - left + 2)*sizeof(char));
          strncpy(word, str + left , right - left);
          printf("'%s' IS A STRING literal\n", word);
          left = right;
          continue;
        }
        if (isEndDel && (left == right)) {
            // check for operators
            for(int i=0;i<operlen;i++){
                if(str[right] == operators[i]){
                    printf("'%c' IS AN OPERATOR\n", str[right]);
                    break;
                }
            }
            right++;
            left = right;
        } else if ((isEndDel == true && left != right) || (right == len && left != right)) {
            char* word = (char *) malloc((right - left + 2)*sizeof(char));
            strncpy(word, str + left, right - left);
            word[right-left ] = '\0';
            int lengt = right-left;
            bool isDone = false;
            for(int i=0;i<22;i++){
                if(!strcmp(keywords[i], word) && isDone == false){
                    printf("'%s' IS A KEYWORD\n", word);
                    isDone = true;
                }
            }
            if(isDone == false) {
                int i = 0;
                if (word[0] == '-') {
                    i = 1;
                }
                bool isint = true;
                for (; i < lengt; i++) {
                    if (word[i] < '0' || word[i] > '9') {
                        isint = false;
                        break;
                    }
                }
                if (isint) {
                    printf("'%s' IS AN INTEGER\n", word);
                    isDone = true;
                }
            }
            if(isDone == false) {
                int i = 0;
                bool isfloat = false;
                if (word[0] == '-')
                    i++;
                for (; i < lengt; i++) {
                    if ((word[i] < '0' || word[i] > '9') && word[i] != '.')
                        break;
                    if (word[i] == '.')
                        isfloat = true;
                }
                if (isfloat) {
                    printf("'%s' IS A REAL NUMBER\n", word);
                    isDone = true;
                }
            }
            if(isDone == false){
                bool isDelEnd = false;
                for(int i=0;i<dellen;i++){
                    if(delimiter[i] == str[right - 1]){
                        isDelEnd = true;
                        break;
                    }
                }
                bool isIdenti = true;
                for(int i=0;i<dellen;i++){
                    if(delimiter[i] == word[0] || (word[i] >= '0' && word[i] <= '9')){
                        isIdenti = false;
                        break;
                    }
                }
                if (isIdenti && !isDelEnd  && strlen(word) != 0)
                    printf("'%s' IS A VALID IDENTIFIER\n", word);

                else if (isIdenti == false && !isDelEnd)
                    printf("'%s' IS NOT A VALID IDENTIFIER\n", word);
            }
            left = right;
        }
    }
}

// DRIVER FUNCTION
int main(int argc, char** argv)
{
  char fle[100];
  strcpy(fle,argv[1]);
  char str[10000];
  FILE *fp;
  fp =fopen(fle,"r");
  while (fgets(str,1000,fp)!=NULL){
    parse(str);
  }
  return 0;
}
