set val(chan) Channel/WirelessChannel  ;# channel type
set val(prop) Propagation/TwoRayGround ;# radio-propagation model
set val(netif1) Phy/WirelessPhy        ;# network interface type
set val(netif2) Phy/WirelessPhy        ;# network interface type
set val(mac) Mac/802_11                ;# MAC type
set val(ifq) Queue/DropTail/PriQueue   ;# interface queue type
set val(ll) LL                         ;# link layer type
set val(ant) Antenna/OmniAntenna       ;# antenna model
set val(ifqlen) 50                     ;# max packet in ifq
set val(nn) 4                          ;# number of mobilenodes
set val(rp) AODV                       ;# routing protocol
set val(x) 500                         ;# X dimension of topography
set val(y) 500                         ;# Y dimension of topography
set val(stop) 5.0                      ;# time of simulation end

# Simulator Instance Creation
set ns [new Simulator]

set tracefd  [open vanet.tr w]
set namtrace [open vanet.nam w]
set distfd   [open dist.tr w]

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)
# set up topography object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
# general operational descriptor- storing the hop details in the network
create-god $val(nn)
# For model 'TwoRayGround'

set dist(20m) 4.80696e-07
set dist(26m) 2.84435e-07
set dist(27m) 2.63756e-07
set dist(28m) 2.45253e-07
set dist(25m) 3.07645e-07
set dist(30m) 2.13643e-07
set dist(35m) 1.56962e-07
set dist(50m) 7.69113e-08
set dist(75m) 3.41828e-08
set dist(60m) 5.34106e-08
set dist(70m) 3.92405e-08
set dist(250m) 3.65262e-10
set dist(500m) 2.28289e-11
# unity gain, omni-directional antennas
# set up the antennas to be centered in the node and 1.5 meters above it
Antenna/OmniAntenna set X_ 0
Antenna/OmniAntenna set Y_ 0
Antenna/OmniAntenna set Z_ 1.5
Antenna/OmniAntenna set Gt_ 1.0
Antenna/OmniAntenna set Gr_ 1.0
# Initialize the SharedMedia interface with parameters to make
# it work like the 914MHz Lucent WaveLAN DSSS radio interface

$val(netif1) set CPThresh_ 10.0
$val(netif1) set CSThresh_ $dist(250m)
$val(netif1) set RXThresh_ $dist(250m)
$val(netif1) set Rb_ 2*1e6
$val(netif1) set Pt_ 0.2818
$val(netif1) set freq_ 914e+6
$val(netif1) set L_ 1.0

$val(netif2) set CPThresh_ 10.0
$val(netif2) set CSThresh_ $dist(500m)
$val(netif2) set RXThresh_ $dist(500m)
$val(netif2) set Rb_ 2*1e6
$val(netif2) set Pt_ 0.2818
$val(netif2) set freq_ 914e+6
$val(netif2) set L_ 1.0
# set up topography object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

# Create God
set god_ [create-god $val(nn)]

set chan_1_ [new $val(chan)]

# configure node

$ns node-config -adhocRouting $val(rp) \
                -llType $val(ll)       \
                -macType $val(mac)     \
                -ifqType $val(ifq)     \
                -ifqLen $val(ifqlen)   \
                -antType $val(ant)     \
                -propType $val(prop)   \
                -phyType $val(netif1)  \
                -topoInstance $topo    \
                -agentTrace ON         \
                -routerTrace ON        \
                -macTrace OFF          \
                -movementTrace ON      \
                -channel $chan_1_      \

for {set i 0} {$i < 1 } {incr i} {
    set node_($i) [$ns node]
    $node_($i) color black
    set xx [expr rand()*$val(x)]
    set yy [expr rand()*$val(y)]
    $node_($i) set X_ $xx 
    $node_($i) set Y_ $yy
    #$node_($i) rand-motion 0 ;# disable rand motion
}

$ns node-config -adhocRouting $val(rp) \
                -llType $val(ll)       \
                -macType $val(mac)     \
                -ifqType $val(ifq)     \
                -ifqLen $val(ifqlen)   \
                -antType $val(ant)     \
                -propType $val(prop)   \
                -phyType $val(netif2)  \
                -topoInstance $topo    \
                -agentTrace ON         \
                -routerTrace ON        \
                -macTrace OFF          \
                -movementTrace ON      \
                -channel $chan_1_      \

for {set i 1} {$i < 4 } {incr i} {
    set node_($i) [$ns node]
    $node_($i) color brown
    $node_($i) set X_ [expr rand() * $val(x)]
    $node_($i) set Y_ [expr rand() * $val(y)]
}

$ns at 0.5 "$node_(0) setdest 250.0 250.0 50.0"
$ns at 0.7 "$node_(1) setdest 45.0 285.0 60.0"
$ns at 0.5 "$node_(2) setdest 350.0 250.0 50.0"
$ns at 0.7 "$node_(3) setdest 145.0 385.0 60.0"

proc finish {} {
    global ns tracefd namtrace distfd
    $ns flush-trace
    close $tracefd
    close $distfd
    close $namtrace
    exec nam vanet.nam &
    exit 0
}

proc record {} {
    global ns distfd node_ val
    set tick 0.5
    set now [$ns now]

    for {set i 0} {$i < $val(nn)} {incr i} {
        for {set j [expr $i+1]} {$j < $val(nn)} {incr j} {
            set srcnode_x [$node_($i) set X_]
            set srcnode_y [$node_($i) set Y_]

            set destnode_x [$node_($j) set X_]
            set destnode_y [$node_($j) set Y_]

            set distance [expr pow(pow($destnode_x - $srcnode_x,2) + pow($destnode_y - $srcnode_y,2),0.5)]

            puts $distfd "$now $i $srcnode_x $srcnode_y $j $destnode_x $destnode_y $distance"
        }
    }

    $ns at [expr $now+$tick] "record"
}

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$tcp set class_ 2

$ns attach-agent $node_(1) $tcp
$ns attach-agent $node_(2) $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 0.5 "$ftp start"
$ns at 4.5 "$ftp stop"
$ns at 0.5 "record"

for {set i 0} {$i < $val(nn)} {incr i} {
    $ns initial_node_pos $node_($i) 30
}

for {set i 0} {$i < $val(nn)} {incr i} {
    $ns at $val(stop) "$node_($i) reset"
}

$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at 5.1 "puts \"NS Exiting\"; $ns halt"

$ns run
