BEGIN {
receive = 0
drop = 0
total = 0
}
{
if ($1 == "r") {
receive++
}
if ($1 == "d") {
drop++
}
}
END {
total = receive + drop
printf("\nPLR : %.4f", (drop/total)*100)
}
