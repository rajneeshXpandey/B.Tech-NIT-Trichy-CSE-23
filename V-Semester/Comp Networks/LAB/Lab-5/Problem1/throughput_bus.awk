BEGIN {
    recvsize=0;
    currenttime=0;
}
{
    event = $1;
    toNode = $4;
    currenttime = $2;
    if(event =="r" && toNode=="9" ) {
        recvsize+=$6;
    }
    printf("%f %f\n", currenttime, (8*recvsize)/(100000*currenttime));
}
END {
}