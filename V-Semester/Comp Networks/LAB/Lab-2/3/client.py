import socket
import sys
 
#creating 1st socket
try:
    s1 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print ("Socket successfully created")
except socket.error as err:
    print ("socket creation failed with error %s" %(err))

# port for s1
port1 = 80
# port for s2
port2 = 100
#final list
li = []
try:
    host=socket.gethostname()
    print("Host is ",host)
except:
    print ("there was an error resolving the host")
    sys.exit()

#get 5 files from server A
print('\n')
print("Requesting files from server A")
msg="send file"
i = 0
s1.connect((host,port1))
s1.send(bytes(str(msg),'utf-8'))
response=s1.recv(1024).decode("utf-8")
# trim result we get from server A and make it into a list
li = response.strip('][').split(', ')
j=0
for i in li:
    li[j] = i.strip('\'') 
    j = j+1
print("Message recieved from Server A is")
print(li)
print('\n')

#getting the final 5 files from server B
j = 0
print("Requesting files from server B")
for i in li:
    if( i == '' ):
        # create 2nd socket to get from server B one by one
        try:
            s2 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        except socket.error as err:
            print ("socket creation failed with error %s" %(err))
        s2.connect((host,port2))
        s2.send(bytes(str(j),'utf-8'))
        response=s2.recv(1024).decode("utf-8")
        s2.close()
        li[j] = response
    j = j+1
print("Messages recieved from Server B is")
print(li)
final = ""
for i in li:
    final = final + i + ' '
print("\nFinal string is:")
print(final)
s1.close()
