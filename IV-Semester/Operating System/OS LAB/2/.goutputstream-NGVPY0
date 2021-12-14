#! /bin/bash

# To greet the user based on the time of the day. If the time is 5:00 
# AM- 12 PM , greet the user “Good Morning” , else if the time is 
# between 1:00 PM – 5:00 PM, greet  “Good Afternoon”.

time=$(date +"%T")
echo "The current time is $time"
hour=$(date +"%H")
if [ $hour -ge 5 ] && [ $hour -le 12 ]
 then
   echo "Good Morning"
elif [ $hour -ge 13 ] && [ $hour -lt 17 ]
 then
   echo "Good Afternoon"
else
   echo "Time out of Bound !"
fi
