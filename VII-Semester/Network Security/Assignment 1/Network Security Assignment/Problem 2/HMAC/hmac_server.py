import socket
from hmac_main import *

if __name__ == "__main__":
    # print("Conducting Integrity Tests..")
    # integrity_test()

    serverSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM);
    # Bind and listen
    serverSocket.bind(("127.0.0.1",9090));
    serverSocket.listen();

    while(True):

        (clientConnected, clientAddress) = serverSocket.accept();

        print("Accepted a connection request from %s:%s"%(clientAddress[0], clientAddress[1]));
        dataFromClient = clientConnected.recv(1024)
        print("Message recieved")
        message = dataFromClient.decode()
        key = b"e279"
        data = bytes(message, 'utf-8')
        # print(message, hmac(key, data)  )
        temp = input("Change the message sent back to check integrity? (Y/N)")

        if temp == 'y' or temp == 'Y':
            message = message[1:]
            print("Removing only first characted and sending back..")
        return_message = message +"%%"+hmac(key, data)               
        print("Digest + Message Sent...")

        # Send some data back to the client

        clientConnected.send(return_message.encode());

