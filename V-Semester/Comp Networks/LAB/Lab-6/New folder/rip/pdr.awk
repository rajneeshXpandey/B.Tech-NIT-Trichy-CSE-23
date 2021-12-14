BEGIN {
receive = 0
sent = 0
}
{
if ($1 == "r") {
receive++
}
if ($1 == "+") {
sent++
}
}
END {
printf("\nPDR : %.4f", (receive/sent)*100)
}
