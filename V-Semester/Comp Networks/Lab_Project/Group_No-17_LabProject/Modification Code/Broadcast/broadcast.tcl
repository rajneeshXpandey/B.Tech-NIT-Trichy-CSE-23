# ======================================================================
# Define options
# ======================================================================

set val(chan)           Channel/WirelessChannel    ;# channel type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         50                         ;# max packet in ifq
set val(nn)             6                          ;# number of mobilenodes
set val(rp)             AODV                       ;# routing protocol

# ======================================================================
# Main Program
# ======================================================================
#
# Initialize Global Variables
#

set ns_		[new Simulator]
set tracefd     [open base.tr w]
$ns_ use-newtrace
$ns_ trace-all $tracefd

# set up topography object

set topo       [new Topography]
$topo load_flatgrid 500 500


create-god $val(nn)


#  Create the specified number of mobilenodes [$val(nn)] and "attach" them
#  to the channel. 
#  Here two nodes are created : node(0) and node(1)

# configure node



$ns_ node-config -adhocRouting $val(rp) \

			-llType $val(ll) \

			-macType $val(mac) \

			-ifqType $val(ifq) \

			-ifqLen $val(ifqlen) \

			-antType $val(ant) \

			-propType $val(prop) \

			-phyType $val(netif) \

			-channelType $val(chan) \

			-topoInstance $topo \

			-agentTrace ON \

			-routerTrace ON \

			-macTrace ON \

			-movementTrace OFF			

			

for {set i 0} {$i < $val(nn) } {incr i} {

	set node_($i) [$ns_ node]	

	$node_($i) random-motion 0   ;# disable random motion

}


#
# Provide initial (X,Y, for now Z=0) co-ordinates for mobilenodes
#

$node_(0) set X_ 2.0
$node_(0) set Y_ 2.0
$node_(0) set Z_ 0.0

$node_(1) set X_ 300.0
$node_(1) set Y_ 300.0
$node_(1) set Z_ 0.0

$node_(2) set X_ 4.0
$node_(2) set Y_ 4.0
$node_(2) set Z_ 0.0

$node_(3) set X_ 5.0
$node_(3) set Y_ 5.0
$node_(3) set Z_ 0.0



$node_(4) set X_ 400.0
$node_(4) set Y_ 400.0
$node_(4) set Z_ 0.0


$node_(5) set X_ 150.0
$node_(5) set Y_ 150.0
$node_(5) set Z_ 0.0


#
# Now produce some simple node movements
# Node_(2) starts to move towards node_(1)
#

$ns_ at 50.0 "$node_(2) setdest 401.0 401.0 10.0"

# Node_(1) then starts to move away from node_(0)
#$ns_ at 100.0 "$node_(1) setdest 490.0 480.0 15.0" 
# Setup traffic flow between nodes


set b0 [new Agent/Broadcastbase]
$node_(0) attach $b0
set ll [$node_(0) set ll_(0)]
$ns_ at 0.0 "$b0 set-ll $ll"
$ns_ at 10.0 "$b0 send" 


set b1 [new Agent/Broadcastbase]
$node_(1) attach $b1
set ll2 [$node_(1) set ll_(0)]
$ns_ at 0.5 "$b1 set-ll $ll2"
$ns_ at 10.5 "$b1 send"


#
# Tell nodes when the simulation ends
#

for {set i 0} {$i < $val(nn) } {incr i} {
    $ns_ at 150.0 "$node_($i) reset";
}

$ns_ at 150.0 "stop"
$ns_ at 150.01 "puts \"NS EXITING...\" ; $ns_ halt"

proc stop {} {
    global ns_ tracefd
    $ns_ flush-trace
    close $tracefd
}



puts "Starting Simulation..."

$ns_ run
