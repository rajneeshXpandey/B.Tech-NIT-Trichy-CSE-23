import socket
import sys
import random

def decode(Arr):
  new_msg=["","","","","","","","","",""]
  i = 0
  j = 9
  while(i < 5):
    n = random.randint(0,j) 
    j=j-1
    #read file
    f = open("%d.txt"%(Arr[n]+1), "r")
    stri = f.read()
    new_msg[Arr[n]] = stri
    Arr.pop(n)
    i=i+1
  return new_msg

try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print ("Socket successfully created")
except socket.error as err:
    print ("socket creation failed with error %s" %(err))
 

port = 80

try:
  host=socket.gethostname()
  print("Host is ",host)
except:
  print ("there was an error resolving the host")
  sys.exit()

s.bind((host,port)) 
print ("socket binded to %s" %(port))
s.listen(5) 
msg_client1=None
while True:
  Arr = [0,1,2,3,4,5,6,7,8,9]
  c,addr=s.accept()
  print ('Got connection from', addr )
  msg=c.recv(1024).decode('utf-8')
  msg_client1=msg
  print("Message Recieved from Client1")
  new_msg=decode(Arr)
  c.send(bytes(str(new_msg),'utf-8'))
  print("Message is sent from server to client1 ")
  c.close()


 

