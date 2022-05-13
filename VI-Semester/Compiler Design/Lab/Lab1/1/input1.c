#include <stdio.h>
int main()
{
    int array[3],t1,t2;
    t1=2; array[0]=1; array[1]=2; array[t1]=3;
    t2=-(array[2]+t1*6)/(array[2]-t1);
    /* 
       this is a comment
       which is multiline comment
    */
    if (t2>5)
        printf("%d\n",t2);
    else{
        int t3;
        t3=99;
        t2=-25;
        printf("%d\n",-t1+t2*t3); 
    }
    return 0;
}