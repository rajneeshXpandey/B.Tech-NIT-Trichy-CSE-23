import socket
import time
import sys

HEADERSIZE = 10
IP = socket.gethostname()
PORT = 1234

#here msg will be in bytes format
def send(targetsocket, msg):
	time.sleep(3) #as client needs to have some time to recv the msg 
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

def functor(msg):
	new_msg = ""
	for i in msg:
		if i.isalnum():
			if i=='Z':
				new_msg+='A'
			elif i=='z':
				new_msg+='a'
			elif i=='9':
				new_msg+='0'
			else:
				new_msg+=chr(ord(i)+1)
		else:
			new_msg+='.'
	return new_msg


s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((IP , PORT))
s.listen(5)

while True:
	clientsocket, addr = s.accept()
	print(f"Connection from {addr} has been established!!!")

	while True:
		length, msg = recv(clientsocket)
		msg = msg.decode()
		print(f"Message received from client is:{msg}")
		if msg == "BYEBYE":
			new_msg = msg
			send(clientsocket,new_msg.encode())
			sys.exit()
		else :
			new_msg = functor(msg)
			send(clientsocket,new_msg.encode())



