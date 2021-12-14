set val(chan)         Channel/WirelessChannel  
set val(prop)         Propagation/TwoRayGround 
set val(ant)          Antenna/OmniAntenna      
set val(ll)           LL                       
set val(ifq)          Queue/DropTail/PriQueue  
set val(ifqlen)       200                      
set val(netif)        Phy/WirelessPhy          
set val(mac)          Mac/802_11               
set val(nn)           10                                           
set val(x)            1000
set val(y)            1000
set val(energymodel)  EnergyModel
set val(n_ch)         chan_1
# Ad hoc on-demand multipath distance vector (AOMDV) 
set val(protocol)     AOMDV 

set ns [new Simulator]

set f0 [open out0.tr w]
set f1 [open out1.tr w]
set f2 [open out2.tr w]
set f3 [open out3.tr w]
set f4 [open lost0.tr w]
set f5 [open lost1.tr w]
set f6 [open lost2.tr w]
set f7 [open lost3.tr w]
set f8 [open delay0.tr w]
set f9 [open delay1.tr w]
set f10 [open delay2.tr w]
set f11 [open delay3.tr w]

set traceFile [open multicast_out.tr w]
$ns trace-all $traceFile
$ns use-newtrace
set namtrace [open multicast_out.nam w]
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)
set chan_1 [new $val(chan)]

$ns node-config  -adhocRouting $val(protocol) \
                 -llType $val(ll) \
                 -macType $val(mac) \
                 -ifqType $val(ifq) \
                 -ifqLen $val(ifqlen) \
                 -antType $val(ant) \
                 -propType $val(prop) \
                 -phyType $val(netif) \
                 -topoInstance $topo \
                 -agentTrace ON \
                 -routerTrace ON \
                 -macTrace ON \
                 -movementTrace OFF \
                 -channel $chan_1   \
                 -energyModel $val(energymodel) \
                 -rxPower 0.3 \
                 -txPower 0.6 \
                 -initialEnergy 90

for {set i 0} {$i < 4} { incr i } {
            set node_($i) [$ns node]
            $node_($i) random-motion 1 
            $node_($i) color black
            $ns at 0.0 "$node_($i) color black"
            $ns initial_node_pos $node_($i) 20
    }
for {set j 4} {$j < 8} { incr j } {
            set node_($j) [$ns node]
            $node_($j) random-motion 1  
            $node_($j) color red
            $ns at 0.0 "$node_($j) color red"
            $ns initial_node_pos $node_($j) 20
    }
for {set k 8} {$k < 10} { incr k } {
            set node_($k) [$ns node]
            $node_($k) random-motion 1  
            $node_($k) color yellow
            $ns at 0.0 "$node_($k) color blue"
            $ns initial_node_pos $node_($k) 20
    }

$ns at 0.0 "$node_(0) setdest 91.7 68.0 50.0"
$ns at 0.0 "$node_(1) setdest 28.4 168.3 100.0"
$ns at 0.7 "$node_(2) setdest 27.3 227.4 125.0"
$ns at 5.0 "$node_(3) setdest 20.05 3.98 5.0"
$ns at 0.0 "$node_(4) setdest 30.8 435.3 10.0"
$ns at 0.0 "$node_(5) setdest 166.3 64.0 12.0"
$ns at 4.3 "$node_(6) setdest 182.8 384.2 15.0"
$ns at 0.0 "$node_(7) setdest 104.5 226.2 14.0"
$ns at 0.0 "$node_(8) setdest 135.9 105.3 25.0"
$ns at 4.0 "$node_(9) setdest 104.0 436.3 35.0"

$ns at 10.3 "$node_(0) setdest 166.3 64.0 600.0"
$ns at 12.3 "$node_(1) setdest 26.5 113.7 40.0"
$ns at 10.3 "$node_(2) setdest 28.4 168.3 700.0"
$ns at 16.3 "$node_(3) setdest 101.2 4.0 200.0"
$ns at 15.3 "$node_(4) setdest 29.9 372.5 55.0"
$ns at 10.3 "$node_(5) setdest 251.1 64.8 700.0"
$ns at 9.3 "$node_(6) setdest 110.5 361.3 400.0"
$ns at 10.3 "$node_(7) setdest 111.5 168.7 100.0"
$ns at 10.3 "$node_(8) setdest 91.7 68.0 30.0"
$ns at 10.3 "$node_(9) setdest 30.8 435.3 50.0"

$ns at 24.8 "$node_(0) setdest 135.9 105.3 50.0"
$ns at 25.8 "$node_(1) setdest 23.6 63.1 50.0"
$ns at 29.8 "$node_(2) setdest 26.5 113.7 50.0"
$ns at 25.8 "$node_(3) setdest 101.2 4.0 50.0"
$ns at 23.8 "$node_(4) setdest 30.3 293.5 50.0"
$ns at 28.8 "$node_(6) setdest 395.3 363.4 50.0"
$ns at 23.8 "$node_(5) setdest 91.7 68.0 50.0"
$ns at 10.3 "$node_(7) setdest 51.5 168.7 100.0"
$ns at 25.8 "$node_(8) setdest 104.5 226.2 50.0"
$ns at 20.8 "$node_(9) setdest 50.3 342.5 50.0"

$ns at 40.0 "$node_(0) setdest 135.9 105.3 500.0"
$ns at 34.0 "$node_(1) setdest 418.9 215.4 100.0"
$ns at 40.0 "$node_(2) setdest 242.8 207.0 100.0"
$ns at 30.0 "$node_(4) setdest 104.5 150.2 500.0"
$ns at 40.0 "$node_(5) setdest 249.7 319.0 450.0"
$ns at 43.0 "$node_(6) setdest 323.7 8.7 150.0"
$ns at 25.0 "$node_(7) setdest 102.6 486.2 150.0"
$ns at 40.0 "$node_(8) setdest 473.9 440.3 550.0"

$ns at 50.0 "$node_(0) setdest 91.7 68.0 50.0"
$ns at 50.5 "$node_(1) setdest 28.4 168.3 60.0"
$ns at 50.7 "$node_(2) setdest 27.3 227.4 35.0"
$ns at 57.0 "$node_(3) setdest 20.05 3.98 70.0"
$ns at 50.0 "$node_(4) setdest 30.8 435.3 80.0"
$ns at 50.0 "$node_(5) setdest 166.3 64.0 90.0"
$ns at 54.3 "$node_(6) setdest 182.8 384.2 450.0"
$ns at 50.0 "$node_(7) setdest 104.5 226.2 10.0"
$ns at 50.0 "$node_(8) setdest 135.9 105.3 95.0"
$ns at 54.0 "$node_(9) setdest 104.0 436.3 100.0"

set udp0 [new Agent/UDP]
$ns attach-agent $node_(0) $udp0

$ns at 0.0 "$node_(0) label Sender0"

set sink0 [new Agent/LossMonitor]
$ns attach-agent $node_(4) $sink0

$ns at 0.0 "$node_(4) label Reveicer0"

$ns connect $udp0 $sink0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 512
$cbr0 set rate_ 600kb
$cbr0 set interval_ 0.05
$cbr0 set random_ 1
$cbr0 set maxpkts_ 10000
$cbr0 attach-agent $udp0

set udp1 [new Agent/UDP]
$ns attach-agent $node_(1) $udp1

$ns at 0.0 "$node_(1) label Sender1"

set sink1 [new Agent/LossMonitor]
$ns attach-agent $node_(5) $sink1

$ns at 0.0 "$node_(5) label Receiver1"

$ns connect $udp1 $sink1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 512
$cbr1 set rate_ 600kb
$cbr1 set interval_ 0.05
$cbr1 set random_ 1
$cbr1 set maxpkts_ 10000
$cbr1 attach-agent $udp1

set udp2 [new Agent/UDP]
$ns attach-agent $node_(2) $udp2

$ns at 0.0 "$node_(2) label Sender2"

set sink2 [new Agent/LossMonitor]
$ns attach-agent $node_(6) $sink2

$ns at 0.0 "$node_(6) label Receiver2"

$ns connect $udp2 $sink2

set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 512
$cbr2 set rate_ 600kb
$cbr2 set interval_ 0.05
$cbr2 set random_ 1
$cbr2 set maxpkts_ 10000
$cbr2 attach-agent $udp2

set udp3 [new Agent/UDP]
$ns attach-agent $node_(3) $udp3

$ns at 0.0 "$node_(3) label Sender3"

set sink3 [new Agent/LossMonitor]
$ns attach-agent $node_(7) $sink3

$ns at 0.0 "$node_(7) label Receiver3"

$ns connect $udp3 $sink3

set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetSize_ 512
$cbr3 set rate_ 600kb
$cbr3 set interval_ 0.05
$cbr3 set random_ 1
$cbr3 set maxpkts_ 10000
$cbr3 attach-agent $udp3

proc finish {} {
        global ns f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 traceFile namtrace
        close $f0
	close $f1
	close $f2
	close $f3
	close $f4 
        close $f5
        close $f6
        close $f7
        close $f8
        close $f9
        close $f10
        close $f11

 	$ns flush-trace
        close $traceFile
	close $namtrace
	
	exec nam multicast_out.nam &
        exec xgraph out0.tr out1.tr out2.tr out3.tr -geometry 800x400 -t Throughput &
	exec xgraph lost0.tr lost1.tr lost2.tr lost3.tr -geometry 800x400 -t Packet_Loss &
	exec xgraph delay0.tr delay1.tr delay2.tr delay3.tr -geometry 800x400 -t Delay &
        exit 0
}

set holdtime0 0
set holdseq0 0

set holdtime1 0
set holdseq1 0

set holdtime2 0
set holdseq2 0

set holdtime3 0
set holdseq3 0

set holdrate0 0
set holdrate1 0
set holdrate2 0
set holdrate3 0

proc record {} {

    global sink0 sink1 sink2 sink3 f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 holdtime0 holdseq0 holdtime1 holdseq1 holdtime2 holdseq2 holdtime3 holdseq3 holdrate0 holdrate1 holdrate2 holdrate3 

    set ns [Simulator instance]
    set time 0.5
    set now [$ns now]
	
	set bw0 [$sink0 set bytes_]
	set bw1 [$sink1 set bytes_]
    set bw2 [$sink2 set bytes_]
    set bw3 [$sink3 set bytes_]
	set bw4 [$sink0 set nlost_]
    set bw5 [$sink1 set nlost_]
    set bw6 [$sink2 set nlost_]
    set bw7 [$sink3 set nlost_]
	set bw8 [$sink0 set lastPktTime_]
    set bw9 [$sink0 set npkts_]
    set bw10 [$sink1 set lastPktTime_]
    set bw11 [$sink1 set npkts_]
    set bw12 [$sink2 set lastPktTime_]
    set bw13 [$sink2 set npkts_]
    set bw14 [$sink3 set lastPktTime_]
    set bw15 [$sink3 set npkts_]

        puts $f0 "$now [expr (($bw0+$holdrate0)*8)/(2*$time)]"
        puts $f1 "$now [expr (($bw1+$holdrate1)*8)/(2*$time)]"
        puts $f2 "$now [expr (($bw2+$holdrate2)*8)/(2*$time)]"
        puts $f3 "$now [expr (($bw3+$holdrate3)*8)/(2*$time)]"

        puts $f4 "$now [expr $bw4/$time]"
        puts $f5 "$now [expr $bw5/$time]"
        puts $f6 "$now [expr $bw6/$time]"
        puts $f7 "$now [expr $bw7/$time]"


        if { $bw9 > $holdseq0 } {
                puts $f8 "$now [expr ($bw8 - $holdtime0)/($bw9 - $holdseq0)]"
        } else {
                puts $f8 "$now [expr ($bw9 - $holdseq0)]"
        }

        if { $bw11 > $holdseq1 } {

                puts $f9 "$now [expr ($bw10 - $holdtime1)/($bw11 - $holdseq1)]"

        } else {

                puts $f9 "$now [expr ($bw11 - $holdseq1)]"

        }

        if { $bw13 > $holdseq2 } {

                puts $f10 "$now [expr ($bw12 - $holdtime2)/($bw13 - $holdseq2)]"

        } else {

                puts $f10 "$now [expr ($bw13 - $holdseq2)]"

        }

        if { $bw15 > $holdseq3 } {

                puts $f11 "$now [expr ($bw14 - $holdtime3)/($bw15 - $holdseq3)]"

        } else {

                puts $f11 "$now [expr ($bw15 - $holdseq3)]"

        }

  
	$sink0 set bytes_ 0
        $sink1 set bytes_ 0
        $sink2 set bytes_ 0
        $sink3 set bytes_ 0
	
	$sink0 set nlost_ 0
        $sink1 set nlost_ 0
        $sink2 set nlost_ 0
        $sink3 set nlost_ 0

        set holdtime0 $bw8
        set holdseq0 $bw9         
	
	set holdrate0 $bw0
        set holdrate1 $bw1
        set holdrate2 $bw2
        set holdrate3 $bw3

        $ns at [expr $now+$time] "record"
}

for {set i 0} {$i < $val(nn) } {incr i} {

    $ns at 60.0 "$node_($i) reset";
}

$ns at 0.0 "record"
$ns at 1.0 "$cbr0 start"
$ns at 1.5 "$cbr1 start"
$ns at 2.0 "$cbr2 start"
$ns at 2.5 "$cbr3 start"
$ns at 55.0 "$cbr0 stop"
$ns at 56.0 "$cbr1 stop"
$ns at 57.0 "$cbr2 stop"
$ns at 58.0 "$cbr3 stop"
$ns at 60.0 "finish"

$ns at 1.0 "[$node_(8) agent 255] dump-table"

puts "Starting Simulation..."

$ns run