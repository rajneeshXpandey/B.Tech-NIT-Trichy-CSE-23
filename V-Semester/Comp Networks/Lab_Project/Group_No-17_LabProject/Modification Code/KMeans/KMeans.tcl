# Define options
set val(chan)    Channel/WirelessChannel     ;# channel type
set val(prop)    Propagation/TwoRayGround    ;# radio-propagation model
set val(netif)   Phy/WirelessPhy             ;# network interface type
set val(mac)     Mac/802_11                  ;# MAC type
set val(ifq)     Queue/DropTail/PriQueue     ;# interface queue type
set val(ll)      LL                          ;# link layer type
set val(ant)     Antenna/OmniAntenna         ;# antenna model
set val(ifqlen)  50                          ;# max packet in ifq
set val(rp)      DSDV                        ;# routing protocol
set val(x)       800                         ;# X dimension of topography
set val(y)       600                         ;# Y dimension of topography 
set val(stop)    10                          ;# time of simulation end
set CLUSTER_NUM  3
set NETWORK_NODE 30

#Creating simulation:
set ns [new Simulator]

#Creating nam and trace file:
set tracefd [open kmeans.tr w]
set namtrace [open kmeans.nam w]   

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

# set up topography object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
set god_ [create-god $NETWORK_NODE]

# configure the nodes
$ns node-config -adhocRouting $val(rp) \
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
                -macTrace OFF \
                -movementTrace ON
         
# Creating node objects..         
for {set i 0} {$i < $NETWORK_NODE } { incr i } {
     set node($i) [$ns node]     
}
# Node representing color
for {set i 0} {$i < $NETWORK_NODE  } { incr i } {
     $node($i) color red
     $ns at 0.0 "$node($i) color red"
}

## Provide initial location of mobilenodes..
for {set i 0} {$i < $NETWORK_NODE } { incr i } {
     set xx [expr {int(rand()*$val(x))}]
     set yy [expr {int(rand()*$val(y))}]

     $node($i) set X_ $xx
     $node($i) set Y_ $yy
   
     set nodeXpos($i) $xx
     set nodeYpos($i) $yy 
     set nodeZpos($i) 0.0                           
}
# Define node initial position in nam
for {set i 0} {$i < $NETWORK_NODE} { incr i } {
    $ns initial_node_pos $node($i) 30
}

# Procedure for do..while
proc do {body keyword expression} {
    if {$keyword eq "while"} {
       set expression "!($expression)"
    } elseif {$keyword ne "until"} {
       return -code error "unknown keyword \"$keyword\": must be until or while"
    }
    set condition [list expr $expression]
    while 1 {
       uplevel 1 $body
       if {[uplevel 1 $condition]} {
          break
       }
    }
    return
}

# kmeans algorithm
set randnum 0
#set count 0
# Integer Randoum number generation
proc RandomInteger2 {max} {
    return [expr {int(rand()*$max)}]
}

for {set iter 0} {$iter < $CLUSTER_NUM } { incr iter } {
       set generatedrand($iter) -1
}

# do while call
for {set iter 0} {$iter < $CLUSTER_NUM } { incr iter } {
do {
     set firsttime 1
    # set randnum [expr $r % $NETWORK_NODE]
     set randnum [RandomInteger2 29]
     for {set i 0 } {$i < [expr {$i && $firsttime}]} {incr i} {
                     if{$generatedrand($i) == $randnum} {
                         set firsttime 0
                     }
      	    }
           for {set j 0} {$j < 4000} {incr j} {
                       ;
           }
   } while {!$firsttime}

set generatedrand($iter) $randnum
set clusheadXpos($iter)  $nodeXpos($randnum)
set clusheadYpos($iter)  $nodeYpos($randnum)
set clusheadZpos($iter)  $nodeZpos($randnum)
puts "clusheadXpos($iter) = $clusheadXpos($iter)"
puts "clusheadYpos($iter) = $clusheadYpos($iter)"
puts "clusheadZpos($iter) = $clusheadZpos($iter)"

}
for {set iter 0} {$iter < $NETWORK_NODE} {incr iter} {

      set X_pos1 [expr $clusheadXpos(0) - $nodeXpos($iter)]
      set Y_pos1 [expr $clusheadYpos(0) - $nodeYpos($iter)]
      set distmean1($iter) [expr {abs($X_pos1)} + {abs($Y_pos1)}]
      set X_pos2 [expr $clusheadXpos(1) - $nodeXpos($iter)]
      set Y_pos2 [expr $clusheadYpos(1) - $nodeYpos($iter)]
      set distmean2($iter) [expr {abs($X_pos2)} + {abs($Y_pos2)}]
      set X_pos3 [expr $clusheadXpos(2) - $nodeXpos($iter)]
      set Y_pos3 [expr $clusheadYpos(2) - $nodeYpos($iter)]
      set distmean3($iter) [expr {abs($X_pos3)} + {abs($Y_pos3)}]
      puts "distmean1($iter) = $distmean1($iter)"
      puts "distmean2($iter) = $distmean2($iter)"
      puts "distmean3($iter) = $distmean3($iter)"

}    

set listsize1 0
set listsize2 0
set listsize3 0

for {set iter 0} {$iter < $NETWORK_NODE} {incr iter} {
if [expr {$distmean1($iter) < $distmean2($iter)} && {$distmean1($iter) < $distmean3($iter)}] {
       		set cluslist1Xpos($listsize1) $nodeXpos($iter)
                set cluslist1Ypos($listsize1) $nodeYpos($iter)
		set clusnodes1($listsize1) $iter	
		set listsize1 [incr listsize1]
                $node($iter) color green
                $ns at 0.5 "$node($iter) color green"
                puts "listsize1 = $listsize1\n"
} elseif [expr {$distmean2($iter) < $distmean1($iter)} && {$distmean2($iter) < $distmean3($iter)}] {
		set cluslist2Xpos($listsize2) $nodeXpos($iter)
                set cluslist2Ypos($listsize2) $nodeYpos($iter)
		set clusnodes2($listsize2) $iter	
		set listsize2 [incr listsize2]
                $node($iter) color yellow
                $ns at 0.5 "$node($iter) color yellow"
                puts "listsize2 = $listsize2\n"
} else {
      		set cluslist3Xpos($listsize3) $nodeXpos($iter)
                set cluslist3Ypos($listsize3) $nodeYpos($iter)
		set clusnodes3($listsize3) $iter	
		set listsize3 [incr listsize3]
                $node($iter) color blue
                $ns at 0.5 "$node($iter) color blue"
                puts "listsize3 = $listsize3\n"
}
}

set centroidXpos1 0
set centroidYpos1 0
for {set iter 0} {$iter < $listsize1} {incr iter} {
          set centroidXpos1 [expr $centroidXpos1 + $cluslist1Xpos($iter)]
          set centroidYpos1 [expr $centroidYpos1 + $cluslist1Ypos($iter)]
}
set centroidXpos1 [expr $centroidXpos1 /$listsize1]
set centroidYpos1 [expr $centroidYpos1 /$listsize1]

set centroidXpos2 0
set centroidYpos2 0
for {set iter 0} {$iter < $listsize2} {incr iter} {
          set centroidXpos2 [expr $centroidXpos1 + $cluslist2Xpos($iter)]
          set centroidYpos2 [expr $centroidYpos1 + $cluslist2Ypos($iter)]
}
set centroidXpos2 [expr $centroidXpos2 /$listsize1]
set centroidYpos2 [expr $centroidYpos2 /$listsize1]

set centroidXpos3 0
set centroidYpos3 0

for {set iter 0} {$iter < $listsize3} {incr iter} {
          set centroidXpos3 [expr $centroidXpos3 + $cluslist3Xpos($iter)]
          set centroidYpos3 [expr $centroidYpos3 + $cluslist3Ypos($iter)]
}

set centroidXpos3 [expr $centroidXpos3 /$listsize1]
set centroidYpos3 [expr $centroidYpos3 /$listsize1]

#stop procedure..
proc stop {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
    exec nam kmeans.nam &
}

$ns at $val(stop) "stop"

$ns run


