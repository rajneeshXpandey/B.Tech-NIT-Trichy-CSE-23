BEGIN {
	
	
	max_node = 2000;
	nSentPackets = 0.0 ;		
	nReceivedPackets = 0.0 ;
	rTotalDelay = 0.0 ;
	max_pckt = 10000;
	
	idHighestPacket = 0;
	idLowestPacket = 100000;
	rStartTime = 10000.0;
	rEndTime = 0.0;
	nReceivedBytes = 0;

	for(i = 0; i < max_pckt; i++){
		sent[i] = 0;
	}

	PKT_SIZE_CBR=210;
}

{
	# + 2 8 7 tcp 40 ------- 0 8.0 13.0 0 4

	strEvent = $1;  
	rTime = $2;
	from_node = $3;
	to_node = $4;
	pkt_type = $5;
	pkt_size = $6;
	flgStr = $7;
	flow_id = $8;
	src_addr = $9;
	dest_addr = $10;
	pkt_id = $11;

	sub(/^_*/, "", node);
	sub(/_*$/, "", node);

	
	
	if(pkt_type == "cbr"){

		if (pkt_id > idHighestPacket) idHighestPacket = pkt_id;
		if (pkt_id < idLowestPacket) idLowestPacket = pkt_id;	
		
	
		if(rTime<rStartTime) rStartTime=rTime;
		if(rTime>rEndTime) rEndTime=rTime;	

		if ( strEvent == "+" && pkt_size == PKT_SIZE_CBR) {
			
			source = int(from_node)
			potential_source = int(src_addr)

			if(source == potential_source) {
				nSentPackets += 1 ;	
				rSentTime[ pkt_id ] = rTime ;
				sent[pkt_id] = 1;
			}
			
		}

		potential_dest = int(to_node)
		dest = int(dest_addr) 

		if ( strEvent == "r" && potential_dest == dest && pkt_size == PKT_SIZE_CBR && sent[pkt_id] == 1) {
			nReceivedPackets += 1 ;		
			nReceivedBytes += pkt_size;

			rReceivedTime[ pkt_id ] = rTime ;
			rDelay[pkt_id] = rReceivedTime[ pkt_id] - rSentTime[ pkt_id ];
			rTotalDelay += rDelay[pkt_id]; 
		}
		if(strEvent == "d" && pkt_size == PKT_SIZE_CBR){
			# printf("Packet Dropped\n");
			
			nDropPackets += 1;
		}
	}
	
}

END {

	rTime = rEndTime - rStartTime ;
	rThroughput = nReceivedBytes*8 / rTime;
	rPacketDeliveryRatio = (nReceivedPackets / nSentPackets) * 100 ;
	rPacketDropRatio = (nDropPackets / nSentPackets) * 100;

	if ( nReceivedPackets != 0 ) {
		rAverageDelay = rTotalDelay / nReceivedPackets ;
	}
	printf( "%15.2f\n%15.5f\n%15.2f\n%15.2f\n", rThroughput, rAverageDelay, nSentPackets, nReceivedPackets);
	printf( "%15.2f\n%10.2f\n%10.2f\n%10.5f\n", nDropPackets, rPacketDeliveryRatio, rPacketDropRatio,rTime);
	printf("%15.5f\n",rTotalDelay);

}


