# Ques 5c

## Problem Statement
Write a socket program to enable client1 to send a float value to
the server. The server process should increase the value of the number
it receives by a power of 1.5. The server should print both the value it
receives and the value that it sends. Client2 should print the value it
receives from the server.

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
