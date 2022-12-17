import socket
from hmac_main import *
if __name__ == "__main__":
    
    clientSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM);
    clientSocket.connect(("127.0.0.1",9090));
    data = "Hello Server!";
    print("Message Sent...")
    clientSocket.send(data.encode());
    dataFromServer = clientSocket.recv(1024);
    print("Digest + Message Recieved...")

    data = dataFromServer.decode().split("%%")
    message = bytes(data[0], 'utf-8')
    digest = bytes(data[1], 'utf-8')

    print("Message : ", data[0])
    print("Confidentiality breached!")

 
