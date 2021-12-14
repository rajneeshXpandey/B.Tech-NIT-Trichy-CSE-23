set ns [new Simulator]

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

set N [lindex $argv 0]
set PACKETSIZE [lindex $argv 1] 
for {set i 0} {$i < $N} {incr i} {
    set n($i) [$ns node]
}

# connect each node with all other nodes
for {set i 0} {$i < $N} {incr i} {
    for {set j [expr {$i + 1}]} {$j < $N} {incr j} {
            $ns duplex-link $n($i) $n($j) 1Mb 10ms DropTail
    }
}

# make all odd nodes as udp source and even nodes as null agents
for {set i 1} {$i < $N} {set i [expr {$i + 2}]} {
    # create udp agent
    set udp($i) [new Agent/UDP]
    $ns attach-agent $n($i) $udp($i)

    # create a cbr traffic
    set cbr($i) [new Application/Traffic/CBR]
    $cbr($i) set packetSize_ $PACKETSIZE
    $cbr($i) set interval_ 0.005
    $cbr($i) attach-agent $udp($i)
}

for {set i 0} {$i < $N} {set i [expr {$i + 2}]} {
    # create null agent
    set null($i) [new Agent/Null]
    $ns attach-agent $n($i) $null($i)
}

for {set i 1} {$i < $N} {set i [expr {$i + 2}]} {
    for {set j 0} {$j < $N} {set j [expr {$j + 2}]} {
        $ns connect $udp($i) $null($j)
    }
    $ns at 0.0 "$cbr($i) start"
    $ns at 200.0 "$cbr($i) stop"
}

# call finish after 200s
$ns at 200.0 "finish"

# run simulation
$ns run