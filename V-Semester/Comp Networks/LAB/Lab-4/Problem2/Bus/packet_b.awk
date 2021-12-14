BEGIN {
src="0.0"; dst="3.0";
num_samples = 0;
total_delay = 0;
}
/^\+/&&$9==src&&$10==dst {
t_arr[$12] = $2;
};
/^r/&&$9==src&&$10==dst{
if (t_arr[$12] > 0) {
num_samples++;
delay = $2 - t_arr[$12];
total_delay += delay;
};
};
END{
avg_delay = total_delay/num_samples;
print "Average end-to-end transmission delay is " avg_delay " seconds";
print "Measurement details:";
print " - Since packets are created from the address " src;
print " - Until the packets are destroyed at the address " dst;
};