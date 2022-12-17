import socket
from hmac_main import *
 

if __name__ == "__main__":
    clientSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM);
    clientSocket.connect(("127.0.0.1",9090));
    data = "Hello Server!";
    print("Message Sent...")
    clientSocket.send(data.encode());

    

    # Receive data from server

    dataFromServer = clientSocket.recv(1024);
    print("Digest + Message recieved...")
    print("Verifying...")

    data = dataFromServer.decode().split("%%")
    message = bytes(data[0], 'utf-8')
    digest = bytes(data[1], 'utf-8')
    key = b"e279"
    # print(digest)
    if hmac(key, message) == data[1]:
        print("Digest matches message")
    else: 
        print("Digest does NOT match message")
        
    print("Integrity preserved")

    
