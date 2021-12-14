BEGIN {


         sendLine = 0;


         recvLine = 0;


         fowardLine = 0;


}


{

if ($1=="r" && $4==3){


         recvLine++;


}






if ($1=="d"){


          fowardLine++;


}


}


 END {


         printf "r:%d, d:%d \n",recvLine,fowardLine;


 }

