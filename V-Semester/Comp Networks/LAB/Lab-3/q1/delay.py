import collections
import sys

highest_packet_id = 0
src  =0.0
dst=4.0

start_time = {}
end_time = {}

def process(line:str):
    global highest_packet_id,packetId,start_time,end_time
    cols = line.split()
    eventType=cols[0]
    time = cols[1]
    packetType = cols[4]
    packetSize = cols[5]
    packetId = int(cols[11])
    srcAddr = cols[8]
    dstAddr = cols[9]

    if(cols[4]=="tcp" and cols[0]=="r"):
        if(packetId > highest_packet_id):
            highest_packet_id = packetId
        if(start_time.get(packetId,0)==0 and float(cols[8])==src):
            start_time[packetId]=float(time)
        elif(float( cols[9] )==dst):
            end_time[packetId] = float(time)

def end():
    global highest_packet_id, start_time,end_time
    for packet_id in range(highest_packet_id+1):
        start = start_time.get(packet_id,0)
        nd = end_time.get(packet_id,0)
        if nd>start and end_time.get(packet_id,0)!=-1:
            delay = nd-start
            print("{} {}".format(float(start),float(delay)))

def main():
    if(len(sys.argv)==1):
        print("Usage python delay.py <filename>")
    file = sys.argv[1]
    for line in open(file).readlines():
        process(line)
    end()

main()
