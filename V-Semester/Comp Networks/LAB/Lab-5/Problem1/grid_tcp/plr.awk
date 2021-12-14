BEGIN {
    pksend=0;
    pktrec=0;
    currenttime=0;
}
{
    event = $1;
    toNode = $4;
    fromNode = $3;
    currenttime = $2;
    if(event =="r" && toNode=="24")
    {
        pktrec++;
    }
    if (event=="+" && fromNode=="1")
    {
        pksend++;
    }
    if (pksend > 0) 
    {
        printf("%f %f\n",currenttime,(pksend-pktrec)/pksend);
    }
}
END {
}
