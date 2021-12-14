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
set tracefile [open Grid.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open Grid.nam w]
$ns namtrace-all $namfile

#===================================
#        Nodes Definition        
#===================================
#Create 25 nodes
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
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]
set n16 [$ns node]
set n17 [$ns node]
set n18 [$ns node]
set n19 [$ns node]
set n20 [$ns node]
set n21 [$ns node]
set n22 [$ns node]
set n23 [$ns node]
set n24 [$ns node]

#===================================
#        Links Definition        
#===================================
#Createlinks between nodes
$ns duplex-link $n0 $n1 2.0Mb 10ms DropTail
$ns queue-limit $n0 $n1 50
$ns duplex-link $n1 $n2 2.0Mb 10ms DropTail
$ns queue-limit $n1 $n2 50
$ns duplex-link $n2 $n3 2.0Mb 10ms DropTail
$ns queue-limit $n2 $n3 50
$ns duplex-link $n3 $n4 2.0Mb 10ms DropTail
$ns queue-limit $n3 $n4 50
$ns duplex-link $n4 $n9 2.0Mb 10ms DropTail
$ns queue-limit $n4 $n9 50
$ns duplex-link $n9 $n14 2.0Mb 10ms DropTail
$ns queue-limit $n9 $n14 50
$ns duplex-link $n14 $n19 2.0Mb 10ms DropTail
$ns queue-limit $n14 $n19 50
$ns duplex-link $n19 $n24 2.0Mb 10ms DropTail
$ns queue-limit $n19 $n24 50
$ns duplex-link $n1 $n6 2.0Mb 10ms DropTail
$ns queue-limit $n1 $n6 50
$ns duplex-link $n2 $n7 2.0Mb 10ms DropTail
$ns queue-limit $n2 $n7 50
$ns duplex-link $n3 $n8 2.0Mb 10ms DropTail
$ns queue-limit $n3 $n8 50
$ns duplex-link $n0 $n5 2.0Mb 10ms DropTail
$ns queue-limit $n0 $n5 50
$ns duplex-link $n5 $n10 2.0Mb 10ms DropTail
$ns queue-limit $n5 $n10 50
$ns duplex-link $n5 $n6 2.0Mb 10ms DropTail
$ns queue-limit $n5 $n6 50
$ns duplex-link $n6 $n7 2.0Mb 10ms DropTail
$ns queue-limit $n6 $n7 50
$ns duplex-link $n7 $n8 2.0Mb 10ms DropTail
$ns queue-limit $n7 $n8 50
$ns duplex-link $n8 $n9 2.0Mb 10ms DropTail
$ns queue-limit $n8 $n9 50
$ns duplex-link $n6 $n11 2.0Mb 10ms DropTail
$ns queue-limit $n6 $n11 50
$ns duplex-link $n7 $n12 2.0Mb 10ms DropTail
$ns queue-limit $n7 $n12 50
$ns duplex-link $n8 $n13 2.0Mb 10ms DropTail
$ns queue-limit $n8 $n13 50
$ns duplex-link $n10 $n11 2.0Mb 10ms DropTail
$ns queue-limit $n10 $n11 50
$ns duplex-link $n11 $n12 2.0Mb 10ms DropTail
$ns queue-limit $n11 $n12 50
$ns duplex-link $n12 $n13 2.0Mb 10ms DropTail
$ns queue-limit $n12 $n13 50
$ns duplex-link $n13 $n14 2.0Mb 10ms DropTail
$ns queue-limit $n13 $n14 50
$ns duplex-link $n10 $n15 2.0Mb 10ms DropTail
$ns queue-limit $n10 $n15 50
$ns duplex-link $n11 $n16 2.0Mb 10ms DropTail
$ns queue-limit $n11 $n16 50
$ns duplex-link $n12 $n17 2.0Mb 10ms DropTail
$ns queue-limit $n12 $n17 50
$ns duplex-link $n13 $n18 2.0Mb 10ms DropTail
$ns queue-limit $n13 $n18 50
$ns duplex-link $n15 $n16 2.0Mb 10ms DropTail
$ns queue-limit $n15 $n16 50
$ns duplex-link $n16 $n17 2.0Mb 10ms DropTail
$ns queue-limit $n16 $n17 50
$ns duplex-link $n17 $n18 2.0Mb 10ms DropTail
$ns queue-limit $n17 $n18 50
$ns duplex-link $n18 $n19 2.0Mb 10ms DropTail
$ns queue-limit $n18 $n19 50
$ns duplex-link $n15 $n20 2.0Mb 10ms DropTail
$ns queue-limit $n15 $n20 50
$ns duplex-link $n16 $n21 2.0Mb 10ms DropTail
$ns queue-limit $n16 $n21 50
$ns duplex-link $n17 $n22 2.0Mb 10ms DropTail
$ns queue-limit $n17 $n22 50
$ns duplex-link $n18 $n23 2.0Mb 10ms DropTail
$ns queue-limit $n18 $n23 50
$ns duplex-link $n20 $n21 2.0Mb 10ms DropTail
$ns queue-limit $n20 $n21 50
$ns duplex-link $n21 $n22 2.0Mb 10ms DropTail
$ns queue-limit $n21 $n22 50
$ns duplex-link $n22 $n23 2.0Mb 10ms DropTail
$ns queue-limit $n22 $n23 50
$ns duplex-link $n23 $n24 2.0Mb 10ms DropTail
$ns queue-limit $n23 $n24 50

#Give node position (for NAM)
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n3 $n4 orient right
$ns duplex-link-op $n4 $n9 orient left-down
$ns duplex-link-op $n9 $n14 orient left-down
$ns duplex-link-op $n14 $n19 orient left-down
$ns duplex-link-op $n19 $n24 orient left-down
$ns duplex-link-op $n1 $n6 orient left-down
$ns duplex-link-op $n2 $n7 orient left-down
$ns duplex-link-op $n3 $n8 orient left-down
$ns duplex-link-op $n0 $n5 orient left-down
$ns duplex-link-op $n5 $n10 orient left-down
$ns duplex-link-op $n5 $n6 orient right
$ns duplex-link-op $n6 $n7 orient right
$ns duplex-link-op $n7 $n8 orient right
$ns duplex-link-op $n8 $n9 orient right
$ns duplex-link-op $n6 $n11 orient left-down
$ns duplex-link-op $n7 $n12 orient left-down
$ns duplex-link-op $n8 $n13 orient left-down
$ns duplex-link-op $n10 $n11 orient right
$ns duplex-link-op $n11 $n12 orient right
$ns duplex-link-op $n12 $n13 orient right
$ns duplex-link-op $n13 $n14 orient right
$ns duplex-link-op $n10 $n15 orient left-down
$ns duplex-link-op $n11 $n16 orient left-down
$ns duplex-link-op $n12 $n17 orient left-down
$ns duplex-link-op $n13 $n18 orient left-down
$ns duplex-link-op $n15 $n16 orient right
$ns duplex-link-op $n16 $n17 orient right
$ns duplex-link-op $n17 $n18 orient right
$ns duplex-link-op $n18 $n19 orient right
$ns duplex-link-op $n15 $n20 orient left-down
$ns duplex-link-op $n16 $n21 orient left-down
$ns duplex-link-op $n17 $n22 orient left-down
$ns duplex-link-op $n18 $n23 orient left-down
$ns duplex-link-op $n20 $n21 orient right
$ns duplex-link-op $n21 $n22 orient right
$ns duplex-link-op $n22 $n23 orient right
$ns duplex-link-op $n23 $n24 orient right

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink1 [new Agent/TCPSink]
$ns attach-agent $n24 $sink1
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
    exec nam Grid.nam &
    exit 0
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
