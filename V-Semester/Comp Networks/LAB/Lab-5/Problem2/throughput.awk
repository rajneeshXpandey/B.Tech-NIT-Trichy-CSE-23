BEGIN{
stime=0
ftime=0
flag=0
fsize=0
throughput=0
latency=0
}
{
if($5 == "tcp"){
if($1 == "r" && $4==24)
{
fsize += $6
if(flag == 0)
{
stime=$2
flag=1
}
ftime=$2
}
}
}
END{
latency = ftime-stime
throughput = (fsize*8)/latency
printf("%d ",ftime*100)
printf("%f \n",throughput*100)
}
