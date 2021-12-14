#Usage: ns rip.tcl N
if {$argc!=1} {
	puts stderr "ERROR ! ns called with wrong number of arguments ($argc)"
	exit 1
} else {
	set N [lindex $argv 0]
}

set ns [new Simulator]
$ns rtproto DV

set tracefile [open out.tr w]
$ns trace-all $tracefile
set namfile [open out.nam w]
$ns namtrace-all $namfile

proc finish {} {
	global ns tracefile namfile N
	$ns flush-trace
	close $tracefile
	close $namfile
	#exec nam out.nam &
	exec awk -f pdr.awk out.tr &
	exec awk -f plr.awk out.tr &
	exec awk -f overhead.awk out.tr &
	exec awk -f energy.awk out.tr &
	exit 0
}

for {set i 0} {$i < $N} {incr i} {
	set nodes_array($i) [$ns node]
}

for {set j 0} {$j < $N} {incr j} {
	for {set k [expr $j+1]} {$k < $N} {incr k} {
		$ns duplex-link $nodes_array($j) $nodes_array($k) 5Mb 10ms DropTail
	}
}

set half_N [expr $N/2]

for {set i 0} {$i < $half_N} {incr i} {
	set tcp_array($i) [new Agent/TCP]
	$ns attach-agent $nodes_array($i) $tcp_array($i)
	set tcpSink_array($i) [new Agent/TCPSink]
	$ns attach-agent $nodes_array([expr $i+$half_N]) $tcpSink_array($i)
	$ns connect $tcp_array($i) $tcpSink_array($i)	
}

for {set i 0} {$i < $half_N} {incr i} {
	set ftp_array($i) [new Application/FTP]
	$ftp_array($i) attach-agent $tcp_array($i)
}

set N_links [expr [expr $N*[expr $N-1]]/2]
set links_down_total [expr {int([expr 0.15*$N_links])}]
set links_down_up [expr {int([expr 0.5*$links_down_total])}]
set links_down_up_later [expr {int([expr $links_down_total-$links_down_up])}]

#puts "$N_links $links_down_total $links_down_up $links_down_up_later"

set k 0
for {set i 0} {$k < $links_down_total} {incr i} {
	for {set j [expr $i+1]} {($j < $N) && ($k < $links_down_total)} {incr j} {
		set l_down_s($k) $nodes_array($i)
		set l_down_d($k) $nodes_array($j)
		set k [expr $k+1]
	}
}

for {set i 0} {$i < $half_N} {incr i} {
	$ns at 1.0 "$ftp_array($i) start"
}


#for {set i 0} {$i < $links_down_total} {incr i} {
#	$ns rtmodel-at 30.0 down $l_down_s($i) $l_down_d($i)
#}
#for {set i 0} {$i < $links_down_up} {incr i} {
#	$ns rtmodel-at 60.0 up $l_down_s($i) $l_down_d($i)
#}
#for {set i $links_down_up} {$i < $links_down_total} {incr i} {
#	$ns rtmodel-at 90.0 up $l_down_s($i) $l_down_d($i)
#}

#for {set i 0} {$i < $half_N} {incr i} {
#	$ns at 99.0 "$ftp_array($i) stop"
#}



$ns at 100.0 "finish"
$ns run





