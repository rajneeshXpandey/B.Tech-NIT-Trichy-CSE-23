import socket 
import time
import sys
 
HEADERSIZE = 10
IP = socket.gethostname()
PORT = 1234

#here msg will be in bytes format every time 
def send(targetsocket, msg):
	time.sleep(3) #this is very important as client needs to have some time to recv the msg 
	msg = bytes(f"{len(msg):<{HEADERSIZE}}","utf-8") + msg
	targetsocket.send(msg)

def recv(targetsocket):	
	full_msg=b''
	new_msg=True

	while True:
		msg = targetsocket.recv(16)
		if new_msg:
			# print(f"new message length: {msg[:HEADERSIZE]}")
			msglen = int(msg[:HEADERSIZE].decode().strip())
			if not msglen:
				print("nothing to be received from other side")
				return (0,b"")
			new_msg = False

		full_msg+=msg

		if len(full_msg)-HEADERSIZE == msglen:
			# print("Full msg recvd")
			# print(f"Msg len is ,{msglen} and the msg in bytes is:{full_msg[HEADERSIZE:]}")
			return (msglen , full_msg[HEADERSIZE:])


s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((IP , PORT))
print("connected")

while True :
	msg = input(">>>")
	send(s,msg.encode())
	length, msg = recv(s)
	msg = msg.decode()
	print(f"Message received from server is:{msg}")
	if msg == "BYEBYE":
		sys.exit()
	