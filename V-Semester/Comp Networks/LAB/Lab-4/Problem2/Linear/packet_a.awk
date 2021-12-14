BEGIN {
fromNode=2; toNode=3;
num_samples = 0;
total_delay = 0;
}
/^\+/&&$3==fromNode&&$4==toNode {
t_arr[$12] = $2;
};
/^r/&&$3==fromNode&&$4==toNode {
if (t_arr[$12] > 0) {
num_samples++;
delay = $2 - t_arr[$12];
total_delay += delay;
};
};
END{
avg_delay = total_delay/num_samples;
print "Average queuing transmission delay is " avg_delay " seconds";
print "Measurement details:";
print " - Start when packets enter the node " fromNode;
print " - Until the packets arrive the node " toNode;
};
