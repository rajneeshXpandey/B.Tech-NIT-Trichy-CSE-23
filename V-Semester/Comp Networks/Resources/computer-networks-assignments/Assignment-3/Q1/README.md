# Problem Statement

Please refer the problem 1 of Assignment #2. In this lab, you will convert your previous program
to work with the Internet protocol family. Use the stream services and build a client and server to
perform the same functions that you did before. Determine the Internet address of the machine
your server uses and put it in the connect structure. You can use any port that you want, between
13000 and 65535 safely. Note that if you happen to pick the same port as someone else, you
could have a conflict and a server may fail when it tries to open the port, but the likelihood is
small.
The only logical change you need to make is to implement your exchange of messages as a
protocol. The protocol will be structured as follows (note, a string of digits followed by a b means
a binary number):
Requests:
byte content
---- -------
0 request code, 0000001b = name, 00001001b = number
1-n request data
n+1 end-of-request, 00000011b (ETX)
Replies:
byte content
---- -------
0-n reply data
n+1 end-of-reply, 00000011b (ETX)
Note that the requests allow for both name and number matching, so you need to also be able to
match a name. Nothing fancy, an exact match is required. Also note that the character string can
contain any type of byte oriented data, including binary representations of numbers. For example:
short val;
char * message;
message = &val;
send (sock, message, 2, 0);
