BEGIN{
recieve=0
drop=0
total=0
ratio=0
plr =0
ftime =0
}
{
if($5 == "cbr"){
if($1=="r" && $4==3)
{
recieve++
}
if($1=="d" && $4==3)
{
drop++
}
ftime = $2;
}
}
END{
total=recieve+drop
ratio=(recieve/total)*100
plr = 1-ratio
#printf("\n total packets lost: %d",drop)
printf("%d ",ftime*100)
printf("%f \n",ratio*100)
#printf("\n plr ratio:%f",plr)
}
