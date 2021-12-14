# Ques 4

## Problem Statement
Write a simple client server program using STREAM socket that provides chat
facility. Your application allows a user on one machine to type in and send text
to a user on another machine.

![](https://img.shields.io/badge/Language-C-orange.svg)

## Instructions to run client server chat program

1. Compile tcpclient and tcpserver using gcc.  
`gcc tcpclient.c -o client`  
`gcc tcpserver.c -o server`
2. Open two terminals, run server in one and client in the other. Make sure to run server before client.  
`./server`  
`./client`
3. Now the communication between client can server can proceed. Send a message from client, it will be received on server and same happens from server to client.
4. To end the chat, send `bye` as a message.

![](https://ForTheBadge.com/images/badges/built-with-love.svg)
