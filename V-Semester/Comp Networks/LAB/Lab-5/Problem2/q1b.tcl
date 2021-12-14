set ns [new Simulator]

$ns color 1 Red
$ns color 2 Blue

set nf [open out.nam w]
$ns namtrace-all $nf

set tf [open all.tr w]
$ns trace-all $tf

for {set i 0} {$i<10} {incr i} {
set n($i) [$ns node]
}
#Creating  Lan connection between the nodes
#set lan0 [$ns newLan “$node1 $node2 $node3 $node4 $node5” 0.7Mb 20ms LL Queue/FQ MAC/Csma/Cd Channel]
set lan [$ns newLan "$n(0) $n(1) $n(2) $n(3) $n(4) $n(5) $n(6) $n(7) $n(8) $n(9)" 0.1Mb 50ms LL Queue/DropTail MAC/Csma Channel]

set tcp [new Agent/TCP]
$tcp set class_ 1
$ns attach-agent $n(0) $tcp
set ftp [new Application/FTP]
$ftp attach-agent $tcp

$tcp set fid_ 1
set sink [new Agent/TCPSink]
$ns attach-agent $n(9) $sink

$ns connect $tcp $sink

set udp [new Agent/UDP]
$udp set class_ 2
$ns attach-agent $n(0) $udp
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

$udp set fid_ 2
set null [new Agent/Null]
$ns attach-agent $n(9) $null

$ns connect $udp $null

proc finish {} {
	global nf ns tf
	$ns flush-trace
	close $nf
	close $tf
	exec nam out.nam &
	exit 0
}


$ns at 1.0 "$ftp start"
$ns at 30.0 "$cbr start"
$ns at 49.0 "$ftp stop"
$ns at 49 "$cbr stop"
$ns at 50 "finish"
$ns run

