# Assignment 1

[![Generic badge](https://img.shields.io/badge/Computer-Networks-<BLUE>.svg)](https://shields.io/)


## Ques 3
Implement linked list and all its operation and demonstrate with suitable
input/output operations.

## Ques 4
Write a simple client-server program using STREAM socket that provides chat
facility. Your application allows a user on one machine to type in and send text
to a user on another machine.

## Ques 5a
Create three programs, two of which are clients to a single server.
Client1 will send a character to the server process. The server will
decrement the letter to the next letter in the alphabet and send the
result to client2. Client2 prints the letter it receives and then all the
processes terminate. Compile and run this exercise in both the UNIX
and the Internet domains.

## Ques 5b
Follow the same procedure as in part a except that the data type of the
message should be integer and the server should decrement the integer
before transmitting it to client2.

## Ques 5c
Next write a socket program to enable client1 to send a float value to
the server. The server process should increase the value of the number
it receives by a power of 1.5. The server should print both the value it
receives and the value that it sends. Client2 should print the value it
receives from the server.

## Ques 5d
Send a C structure that includes data of type character, integer and
float from client1 to the server. The server should change the values so
that client2 receives a structure with entirely different data. It is not
permitted that the data should be converted to any other data type
before transmission. Do this exercise in both the UNIX and the Internet
domains.
