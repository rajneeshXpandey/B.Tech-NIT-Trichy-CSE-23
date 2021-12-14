import sys,os

n = int(sys.argv[1])
if(n%2!=0):
    n=n-1
else:
    n=n-2

os.system("perl throughput.pl all.tr {} 1.0 {}.0 1 > throughput_out_{}".format(n,n,n))
