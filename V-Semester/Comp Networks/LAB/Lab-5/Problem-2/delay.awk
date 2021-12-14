BEGIN{
hid=0
ftime=0
}
{
if($5 == "tcp"){
if($12 > hid) hid = $12;
if(start_time[$12] == 0) start_time[$12] = $2;
if($1 != "d"){
if($1 == "r"){
end_time[$12] = $2;
}
}else{
end_time[$12] = -1;
}
}
ftime = $2;
}
END{
duration ;
for(packetid =0 ;packetid <= hid;packetid++){
start = start_time[packetid];
end = end_time[packetid];
if(start < end)duration += end-start;
}
printf("%d ",ftime*100)
printf("%f \n",duration)
}
