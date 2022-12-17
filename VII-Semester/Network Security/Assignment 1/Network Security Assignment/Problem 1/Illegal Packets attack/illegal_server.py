import socket
 
def verify_packet_format(msg):
   bits_arrangement = [8,8,4,8,16,4]
   total_length = 88
   start_bits = "10000101"
   if len(msg) != 88:
       print("Failed here 1")
       return False
   list_msg = msg.split("00000001")
   print(list_msg)
   i = 0
   if list_msg[0] != start_bits:
       print("Failed here 2")
 
       return False
   for m in list_msg:
       if len(m) == bits_arrangement[i]:
           print("passed", i)
       else:
           print("Failed here 3")
 
           return False
       i = i+1
   return True
 
 
if __name__ == "__main__":
 
 
   serverSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM);
   # Bind and listen
   serverSocket.bind(("127.0.0.1",9093));
   serverSocket.listen();
 
   while(True):
 
       (clientConnected, clientAddress) = serverSocket.accept();
 
       print("Accepted a connection request from %s:%s"%(clientAddress[0], clientAddress[1]));
       dataFromClient = clientConnected.recv(1024)
       print("Message recieved")
       message = dataFromClient.decode()
       print(message)
       while not verify_packet_format(message):
           print("Illegal Packet. Requesting for retransmission...")
           return_message = "send again"
           clientConnected.send(return_message.encode());
           dataFromClient = clientConnected.recv(1024)
           print("Retransmitted message recieved..")
           print("Verifying..")
           message = dataFromClient.decode()

