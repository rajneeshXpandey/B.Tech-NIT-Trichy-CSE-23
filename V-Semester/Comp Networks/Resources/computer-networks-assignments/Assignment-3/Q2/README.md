# Problem Statement

Write a client-server program that provides text and voice chat facility using datagram socket.
Your application allows a user on one machine to talk to a user on another machine. Your
application should provide non blocking chat facility to the users. This means, user can send its
message at any time without waiting for replay from the other side. (Hint: Use select() system
call).
