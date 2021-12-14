# Ques 5c

## Problem Statement
Send a C structure that includes data of type character, integer and
float from client1 to the server. The server should change the values so
that client2 receives a structure with entirely different data. It is not
permitted that the data should be converted to any other data type
before transmission. Do this exercise in both the UNIX and the Internet
domains.

![](https://img.shields.io/badge/Language-C-orange.svg)
![](https://img.shields.io/badge/Language-Bash-orange.svg)

## Instructions to run
1. Compile the files `server.c`, `client1.c` and `client2.c` using the following commands:  
`gcc server.c -o server`  
`gcc client1.c -o client1`  
`gcc client2.c -o client2`
2. Open three terminals, run server, client1 and client2 in the same order. Make sure to run server first and client2 only after client1 has completed its function.  
`./server` (terminal 1)   
`./client1` (terminal 2)  
send data from client1  
`./client2` (terminal 3)   
3. Follow the on screen instructions.


![](https://ForTheBadge.com/images/badges/built-with-love.svg)
