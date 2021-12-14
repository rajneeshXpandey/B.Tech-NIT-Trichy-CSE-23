#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows
$ns color 1 Blue
$ns color 2 Red

#Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf

set all_trace [open all.tr w]
$ns trace-all $all_trace

#Define a 'finish' procedure
proc finish {} {
        global ns nf all_trace
        $ns flush-trace
	#Close the trace file
        close $nf
	close $all_trace
	#Execute nam on the trace file
        exec nam out.nam &
        exit 0
}

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n2 10Mb 1ms DropTail
$ns duplex-link $n1 $n2 10Mb 1ms DropTail
$ns duplex-link $n2 $n3 1Mb 3ms DropTail

$ns duplex-link $n3 $n4 10Mb 1ms DropTail
$ns duplex-link $n3 $n5 10Mb 1ms DropTail

$ns queue-limit $n2 $n3 30
$ns queue-limit $n3 $n2 30

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n4 $n3 orient left-down
$ns duplex-link-op $n5 $n3 orient left-up

#Create a TCP agent and attach it to node n0
set tcp0 [new Agent/TCP]
$tcp0 set class_ 1
$ns attach-agent $n0 $tcp0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP

#Create a TCP agent and attach it to node n1
set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n1 $tcp1

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP

#Create a TCPSink agent (a traffic sink) and attach it to node n4
set null0 [new Agent/TCPSink]
$ns attach-agent $n4 $null0

#Create a TCPSink agent (a traffic sink) and attach it to node n5
set null1 [new Agent/TCPSink]
$ns attach-agent $n5 $null1

#Connect the traffic sources with the traffic sink
$ns connect $tcp0 $null0
$tcp0 set fid_ 1
$ns connect $tcp1 $null1
$tcp1 set fid_ 2


#Schedule events for the CBR agents
$ns at 0.5 "$ftp0 start"
$ns at 0.5 "$ftp1 start"
$ns at 199.5 "$ftp0 stop"
$ns at 199.5 "$ftp1 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 200.0 "finish"

#Run the simulation
$ns run
