set ns [new Simulator]

#Open the nam trace file
set nf [open bus_tcp.nam w]
$ns namtrace-all $nf

set all_trace [open bus_tcp.tr w]
$ns trace-all $all_trace

#Define a 'finish' procedure
proc finish {} {
    global ns nf all_trace
    $ns flush-trace
	#Close the trace file
    close $nf
	close $all_trace
	#Execute nam on the trace file
    exec nam bus_tcp.nam &
    exit 0
}


for {set i 0} {$i < 10} {incr i} {
    set n($i) [$ns node]
}

for {set i 0} {$i < 9} {incr i} {
    $ns duplex-link $n($i) $n([expr ($i+1)]) 2Mb 10ms DropTail
    $ns queue-limit $n($i) $n([expr ($i+1)]) 30
    $ns duplex-link-op $n($i) $n([expr ($i+1)]) orient right
}

set tcp1 [new Agent/TCP]
$ns attach-agent $n(0) $tcp1

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP

set null1 [new Agent/TCPSink]
$ns attach-agent $n(9) $null1

#Connect the traffic sources with the traffic sink
$ns connect $tcp1 $null1

$ns at 1.0 "$ftp1 start"
$ns at 49.0 "$ftp1 stop"
$ns at 50.0 "finish"

#Run the simulation
$ns run
