#===================================
#     Simulation parameters setup
#===================================
set val(stop)   50.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Open the NS trace file
set tracefile [open Bus.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open Bus.nam w]
$ns namtrace-all $namfile

#===================================
#        Nodes Definition        
#===================================
#Create 10 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]

#===================================
#        Links Definition        
#===================================
#Createlinks between nodes
$ns duplex-link $n0 $n1 2.0Mb 10ms DropTail
$ns queue-limit $n0 $n1 50
$ns duplex-link $n6 $n1 2.0Mb 10ms DropTail
$ns queue-limit $n6 $n1 50
$ns duplex-link $n1 $n6 2.0Mb 10ms DropTail
$ns queue-limit $n1 $n6 50
$ns duplex-link $n1 $n2 2.0Mb 10ms DropTail
$ns queue-limit $n1 $n2 50
$ns duplex-link $n2 $n3 2.0Mb 10ms DropTail
$ns queue-limit $n2 $n3 50
$ns duplex-link $n3 $n4 2.0Mb 10ms DropTail
$ns queue-limit $n3 $n4 50
$ns duplex-link $n4 $n5 2.0Mb 10ms DropTail
$ns queue-limit $n4 $n5 50
$ns duplex-link $n3 $n8 2.0Mb 10ms DropTail
$ns queue-limit $n3 $n8 50
$ns duplex-link $n2 $n7 2.0Mb 10ms DropTail
$ns queue-limit $n2 $n7 50
$ns duplex-link $n4 $n9 2.0Mb 10ms DropTail
$ns queue-limit $n4 $n9 50

#Give node position (for NAM)
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n6 $n1 orient right-down
$ns duplex-link-op $n1 $n6 orient left-up
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n3 $n4 orient right
$ns duplex-link-op $n4 $n5 orient right
$ns duplex-link-op $n3 $n8 orient right-up
$ns duplex-link-op $n2 $n7 orient right-down
$ns duplex-link-op $n4 $n9 orient right-down

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink1 [new Agent/TCPSink]
$ns attach-agent $n5 $sink1
$ns connect $tcp0 $sink1
$tcp0 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 49.0 "$ftp0 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam Bus.nam &
    exit 0
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
