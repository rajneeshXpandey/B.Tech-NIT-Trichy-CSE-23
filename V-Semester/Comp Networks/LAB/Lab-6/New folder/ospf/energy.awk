BEGIN{
totaltime=100
flag=0
fsize=0
throughput=0
latency=0
}
{
if($1 == "r")
{
fsize += $6
}
}
END{
throughput = (fsize*8)/totaltime
printf("\nEnergy Consumption : %.4f", throughput*totaltime)
}
