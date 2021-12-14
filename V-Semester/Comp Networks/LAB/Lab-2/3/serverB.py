import socket
import sys
 

def decode(msg):
  new_msg=[]
  for chars in msg:
    if(chars==' '):
      new_msg.append(chars)
    if((ord(chars)>=ord('A') and ord(chars)<=ord('Z')) ):
      new_msg.append(chr(ord('A')+(ord(chars)-ord('A')+1)%26))
    elif((ord(chars)>=ord('a') and ord(chars)<=ord('z'))):
      new_msg.append(chr(ord('a')+(ord(chars)-ord('a')+1)%26))
    elif((ord(chars)>=ord('0') and ord(chars)<=ord('9'))):
      new_msg.append(chr(ord('0')+(ord(chars)-ord('0')+1)%10))
    else:
      new_msg.append('.')
  return str(new_msg)

try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print ("Socket successfully created")
except socket.error as err:
    print ("socket creation failed with error %s" %(err))
 

port = 100

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
  c,addr=s.accept()
  print ('Got connection from', addr )
  msg=c.recv(1024).decode('utf-8')
  msg_client1=msg
  print("Message Recieved from Client1")
  f = open("%d.txt"%(ord(msg_client1)-48+1), "r")
  stri = f.read()
  print(stri)
  c.send(bytes(str(stri),'utf-8'))
  print("Message is sent from server to client1 ")
  c.close()


 

