# Ques 5b

## Problem Statement
Create three programs, two of which are clients to a single server using datagram
socket. Client1 will send an integer to the server process. The server will
decrement the integer and send the result to client2.
Client2 prints the integer it receives and then all the processes terminate. Compile
and run this exercise.

![](https://img.shields.io/badge/Language-C-orange.svg)
![](https://img.shields.io/badge/Language-Bash-orange.svg)

## Instructions to run
1. Compile the files `server.c`, `client1.c` and `client2.c` using :  
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
