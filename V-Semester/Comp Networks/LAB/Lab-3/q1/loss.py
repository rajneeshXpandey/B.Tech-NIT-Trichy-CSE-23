# Usage: 
#
#   python throughput.py <trfile> <destNode> <srcNode.port#> <destNode.port#> 
#                   <granularity> 
#
# Example: plot the throughput of connection 2.0 - 1.0 every 0.5 sec
#
#	python throughput.py out.tr  1 2.0 1.0  0.5
#
# cs558000 example:
#
#    Tracefile:
#       r 0.351867 3 4 tcp 40 ------- 0 0.0 4.0 0 0
#                    ^                  ^^^ ^^^
#    Use:
#	python throughput.py out.tr  4 0.0 4.0  0.5

usage= '''# Usage: 
#
#   python throughput.py <trfile> <destNode> <srcNode.port#> <destNode.port#> 
#                   <granularity> 
#
# Example: plot the throughput of connection 2.0 - 1.0 every 0.5 sec
#
#	python throughput.py out.tr  1 2.0 1.0  0.5
#
# cs558000 example:
#
#    Tracefile:
#       r 0.351867 3 4 tcp 40 ------- 0 0.0 4.0 0 0
#                    ^                  ^^^ ^^^
#    Use:
#	python throughput.py out.tr  4 0.0 4.0  0.5

# #############################################################
'''

import sys

if(len(sys.argv)<6):
    print(usage)
    sys.exit(0)

infile = sys.argv[1]
destnode = int(sys.argv[2])
fromport = sys.argv[3]
toport = sys.argv[4]
granularity = float(sys.argv[5])

sum =0
grantsum = 0
clock =  0

for line in open(infile).readlines():
    x = line.split()
    if( float(x[1])-clock <= granularity) :
        if x[0] =='d':
            if int(x[3]) == destnode and x[8]==fromport and x[9]==toport:
                if x[4]=='tcp':
                    sum = sum + int(x[5])
                    grantsum =  grantsum + int( x[5] )
    else:
        throughput = 0.000008 * sum/granularity
        print("{} {}".format(clock,throughput))
        clock=clock+granularity
        if x[0]=='d' and int( x[3] )==destnode and x[8]==fromport and x[9]==toport and x[4]=='tcp':
            sum = int(x[5])
            grantsum = grantsum + int(x[5])
        else:
            sum = 0

        while (( float(x[1])-clock ) > granularity):
            print("{} {}".format(clock,0.0))
            clock = clock+granularity
            

throughput =  0.000008  * sum/granularity
print("{} {}".format(clock,throughput))
clock = clock + granularity

sys.stderr.write("Average drop rate {} -> {} = {} MBytes/sec\n".format(fromport,toport, 0.000008 * grantsum/clock ))
