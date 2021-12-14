#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red

#Open the NAM trace file
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

for {set i 0} {$i < 25} {incr i} {
    set n($i) [$ns node]
}

for {set i 0} {$i < 5} {incr i} {
    for {set j 0} {$j < 4} {incr j} {
        set k1 [expr {5*$i + $j}]
        set k2 [expr {$k1 + 1}]
        $ns duplex-link $n($k1) $n($k2) 1Mb 10ms DropTail
        $ns duplex-link-op $n($k1) $n($k2) orient right
        $ns queue-limit $n($k1) $n($k2) 30
        $ns queue-limit $n($k2) $n($k1) 30
        $ns duplex-link-op $n($k1) $n($k2) queuePos 0.5
    }
}

for {set i 0} {$i < 5} {incr i} {
    for {set j 0} {$j < 4} {incr j} {
        set k1 [expr {$i + 5*$j}]
        set k2 [expr {$k1 + 5}]
        $ns duplex-link $n($k1) $n($k2) 1Mb 10ms DropTail
        $ns duplex-link-op $n($k1) $n($k2) orient down
        $ns queue-limit $n($k1) $n($k2) 30
        $ns queue-limit $n($k2) $n($k1) 30
        $ns duplex-link-op $n($k1) $n($k2) queuePos 0.5
    }
}

#Setup a TCP connection
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n(0) $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n(24) $sink
$ns connect $tcp $sink
$tcp set fid_ 1

#Setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

#Schedule events for the FTP agents
$ns at 1.0 "$ftp start"
$ns at 49.0 "$ftp stop"

# call finish after 50s
$ns at 50.0 "finish"

# run ns
$ns run
