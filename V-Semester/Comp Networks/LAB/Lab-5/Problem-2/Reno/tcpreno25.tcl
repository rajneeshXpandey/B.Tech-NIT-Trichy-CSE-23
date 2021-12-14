#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red

#Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf

set all_trace [open all.tr w]
$ns trace-all $all_trace

set N 25
set F 13

#Define a 'finish' procedure
proc finish {} {
        global ns nf all_trace srca srcb desta destb
        $ns flush-trace
        #Close the trace file
        close $nf
        close $all_trace
        #Execute nam on the trace file
        exec nam out.nam &
	    exit 0
}


for {set i 0} {$i < [expr 2*$N]} {incr i} {
	set n($i) [$ns node]
}

for {set i $N} {$i < [expr 2*$N-1]} {incr i} {
	$ns duplex-link $n($i) $n([expr $i+1]) 1Mb 10ms DropTail
}

for {set i 0} {$i < $N} {incr i} {
	$ns duplex-link $n($i) $n([expr $i+$N]) 1Mb 10ms DropTail
}

for {set i 0} {$i < $F} {incr i} {
        set tcp($i) [new Agent/TCP/Reno]
        $tcp($i) set class_ 2
        $ns attach-agent $n($i) $tcp($i)
        set sink([expr $i+3]) [new Agent/TCPSink]
        $ns attach-agent $n([expr $i+3]) $sink([expr $i+3])
        $ns connect $tcp($i) $sink([expr $i+3])
        $tcp($i) set fid_ 1
}

for {set i 0} {$i < $F} {incr i} {
        #Setup a FTP over TCP connection
        set ftp($i) [new Application/FTP]
        $ftp($i) attach-agent $tcp($i)
        $ftp($i) set type_ FTP
}


#Call the finish procedure after 50 seconds simulation time
for {set i 0} {$i < $F} {incr i} {
        $ns at 0.5 "$ftp($i) start"
        $ns at 49.5 "$ftp($i) stop"
}

$ns at 50.0 "finish"

#Run the simulation
$ns run
