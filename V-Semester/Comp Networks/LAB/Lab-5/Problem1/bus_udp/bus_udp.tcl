set ns [new Simulator]

#Open the nam trace file
set nf [open bus_udp.nam w]
$ns namtrace-all $nf

set all_trace [open bus_udp.tr w]
$ns trace-all $all_trace

#Define a 'finish' procedure
proc finish {} {
    global ns nf all_trace
    $ns flush-trace
	#Close the trace file
    close $nf
	close $all_trace
	#Execute nam on the trace file
    exec nam bus_udp.nam &
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

set udp1 [new Agent/UDP]
$ns attach-agent $n(0) $udp1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 1000
$cbr1 set interval_ 0.01
$cbr1 attach-agent $udp1

set null1 [new Agent/Null]
$ns attach-agent $n(9) $null1

#Connect the traffic sources with the traffic sink
$ns connect $udp1 $null1

$ns at 1.0 "$cbr1 start"
$ns at 49.0 "$cbr1 stop"
$ns at 50.0 "finish"

#Run the simulation
$ns run
