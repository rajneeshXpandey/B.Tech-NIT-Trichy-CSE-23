# Ques 5a

## Problem Statement
Create three programs, two of which are clients to a single server using datagram
socket. Client1 will send a character to the server process. The server will
decrement the letter to the next letter in the alphabet and send the result to client2.
Client2 prints the letter it receives and then all the processes terminate. Compile
and run this exercise.

![](https://img.shields.io/badge/Language-C-orange.svg)
![](https://img.shields.io/badge/Language-Bash-orange.svg)

## Instructions to run

1.Compile using the following commands:  
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
