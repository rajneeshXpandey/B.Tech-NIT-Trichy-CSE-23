#Creating simulator object
set ns [new Simulator]

#creating two color classes for ns object to distinguish the traffic coming from various sources
$ns color 0 blue
$ns color 1 red

#Creating the nam file
set nf [open out.nam w]
$ns namtrace-all $nf

set tracefile [open analysis.tr w]
$ns trace-all $tracefile

#Finish Procedure
proc finish {} {
        global ns nf tracefile
        $ns flush-trace
        close $nf
        close $tracefile
        exec nam out.nam &
        exit 0
        }

#Creating Four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#Creating a duplex links
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link-op $n0 $n2 orient right-down

$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link-op $n1 $n2 orient right-up

$ns duplex-link $n2 $n3 1.7Mb 20ms DropTail
$ns duplex-link-op $n2 $n3 orient right

#Limiting the queue to only 10 packets 
$ns queue-limit $n0 $n2 10
$ns queue-limit $n1 $n2 10
$ns queue-limit $n2 $n3 10

#Creating a TCP agent and connecting it to n1
set tcp0 [new Agent/TCP]

#Specifying tcp traffic to have blue color as defined in the second line of the program
$tcp0 set fid_ 0

$ns attach-agent $n0 $tcp0

#Creating a Sink Agent and attaching it to n3
set sinkTCP3 [new Agent/TCPSink]
$ns attach-agent $n3 $sinkTCP3

#Connecting TCP agent with Sink agent
$ns connect $tcp0 $sinkTCP3



#Specifying the UDP agent
set udp1 [new Agent/UDP]

#Specifying udp traffic to have red color as defined in the second line of program
$udp1 set fid_ 1

#Attaching the UDP agent with n1
$ns attach-agent $n1 $udp1

#Specifying the Null agent
set null0 [new Agent/Null]

#Attaching the NULL agent with n3
$ns attach-agent $n3 $null0

#Connecting both udp1 and null0 agents for transferring data between n0 and n1
$ns connect $udp1 $null0

#Creating FTP agent for traffic and attaching it to tcp1
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

#Specifying the CBR agent to generate the traffic over udp0 agent
set cbr0 [new Application/Traffic/CBR]

#Each packet having 1K bytes
$cbr0 set packetSize_ 1000

#Each packet will be generated after 10ms i.e., 100 packets per second
$cbr0 set interval 0.010

#Attaching cbr0 with udp0
$cbr0 attach-agent $udp1

#Starting the FTP Traffic
$ns at 0.5 "$ftp0 start"
$ns at 4.0 "$ftp0 stop"

#Starting the cbr0 at 0.5 simulation time
$ns at 0.1 "$cbr0 start"

#Stoping the cbr0 at 4.5 simulation time
$ns at 4.5 "$cbr0 stop"

#Calling the finish procedure
$ns at 5.0 "finish"

#Run the simulation
$ns run

