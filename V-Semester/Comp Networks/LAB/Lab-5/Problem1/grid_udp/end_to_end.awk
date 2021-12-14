BEGIN {
    pksend=0;
    pktrec=0;
    currenttime=0;
    tdelay=0;
}

{
    event = $1;
    toNode = $4;
    fromNode = $3;
    currenttime = $2

    if(event =="r" && toNode=="9")
    {
        tdelay+=currenttime-starttime[$11];
    }
    if (event=="+" && fromNode=="1")
    {
        starttime[$11]=currenttime;
    } 
    printf("%f %f\n",currenttime,tdelay);
}

END {
}
