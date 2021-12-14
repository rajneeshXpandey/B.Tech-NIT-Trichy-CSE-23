import socket 
import threading 
from queue import Queue

print_lock = threading.Lock()

target = 'yahoo.com'

def portscan(port):
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	try :
		con = s.connect((target,port))
		with print_lock:
			print('port',port,'is open !!!')
		con.close()

	except:
		pass

def threader():
	while True:
		worker = q.get()
		portscan(worker)
		q.task_done()# to empty our queue


q = Queue()

for x in range(20):
	t = threading.Thread(target = threader)
	t.daemon = True
	t.start()

#port 0 is an invalid port so we cant scan port 0
for worker in range(1,1027):
	q.put(worker)

q.join() #we wait for thread to terminate


