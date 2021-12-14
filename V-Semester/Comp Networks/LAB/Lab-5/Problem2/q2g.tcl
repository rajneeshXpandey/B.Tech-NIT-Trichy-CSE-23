set ns [new Simulator]

$ns color 1 green
$ns color 2 orange

set namtrace [open out.nam w]
$ns namtrace-all $namtrace

set fulltrace [open all2.tr w]
$ns trace-all $fulltrace

set pdr [open throughput w]
set pdr2 [open throughput2 w]
set del1 [open delay1 w]
set del2 [open delay2 w]
set pdr_1 [open ratio1 w]
set pdr_2 [open ratio2 w]
set plr [open packetLoss w]

for {set i 0} {$i<25} {incr i} {
	set n($i) [$ns node]
}

for {set i 0} {$i<20} {incr i} {
	if {($i+1)%5==0} {
	
	set b [expr $i+5]
	
	$ns duplex-link $n($i) $n($b) 10Mb 10ms DropTail
	$ns duplex-link-op $n($i) $n($b) orient down
	} else {
	set a [expr $i+1]
	set b [expr $i+5]
	$ns duplex-link $n($i) $n($a) 10Mb 10ms DropTail
	$ns duplex-link-op $n($i) $n($a) orient right
	$ns duplex-link $n($i) $n($b) 10Mb 10ms DropTail
	$ns duplex-link-op $n($i) $n($b) orient down
	}
}

for {set i 20} {$i<24} {incr i} {
	set a [expr $i+1]
	$ns duplex-link $n($i) $n($a) 10Mb 10ms DropTail
	$ns duplex-link-op $n($i) $n($a) orient right
}


set tcp [new Agent/TCP]
$tcp set class_ 1
$ns attach-agent $n(0) $tcp
set ftp [new Application/FTP]
$ftp attach-agent $tcp

set udp [new Agent/UDP]
$udp set class_ 2
$ns attach-agent $n(0) $udp
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

set sink [new Agent/TCPSink]
$ns attach-agent $n(24) $sink

set null [new Agent/Null]
$ns attach-agent $n(24) $null

$ns connect $tcp $sink
$ns connect $udp $null


set prevDrops 0

proc record {} {
	global ns namtrace fulltrace pdr pdr2 del1 del2 plr sink pdr_1 pdr_2
	set now [$ns now]
	set time 1.0
	puts $pdr [exec awk -f throughput.awk all2.tr]
	puts $pdr2 [exec awk -f cbr.awk all2.tr]
	puts $del1 [exec awk -f delay.awk all2.tr]
	puts $del2 [exec awk -f delay2.awk all2.tr]
	puts $pdr_1 [exec awk -f pdr.awk all2.tr]
	puts $pdr_2 [exec awk -f pdr2.awk all2.tr]
	$ns at [expr $now+$time] "record"
}

proc finish {} {
	global namtrace ns pdr pdr2 plr fulltrace
	$ns flush-trace
	close $namtrace
	close $fulltrace
	exec nam out.nam &
	exec xgraph throughput throughput2 &
	exec xgraph delay1 delay2 &
	exec xgraph ratio1 ratio2 &
	exit 0
}

$ns at 4.5 record
$ns at 3.1 "$ftp start"
$ns at 4.1 "$cbr start"
$ns at 7.0 "$ftp stop"
$ns at 8.0 "$cbr stop"
$ns at 9.1 "finish"
$ns run
