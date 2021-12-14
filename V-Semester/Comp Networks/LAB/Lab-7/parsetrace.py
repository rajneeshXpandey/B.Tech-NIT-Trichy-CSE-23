import sys
trace_file = open(sys.argv[1])
print ("Please wait......")
fields=[]
for line in iter(trace_file):
    line=line.split(" ")
    if (line[0] in ['r', 'D', 's'] and line[3] == 'MAC' and line[7] == 'cbr') :
      fields.append({'node_id': line[2], 'Event_Type': line[0], 'UPID': int(line[6])})
print ("Parsing Trace File:Done")
print ("Calculating the Probability......")
received_Packet_len = len(set(trace['UPID'] for trace in fields if trace['Event_Type'] == 'r' and trace['node_id'] == '_0_'))
Packets_sent = len(set(trace['UPID'] for trace in fields))
print("Probability: %.2f%%" % (float(received_Packet_len)/Packets_sent*100))
