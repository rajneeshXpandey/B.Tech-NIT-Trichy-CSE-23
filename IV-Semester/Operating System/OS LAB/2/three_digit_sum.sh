#! /bin/bash

#Take the input from user 
read -p "Enter the three digit number : " Num

n=$Num

Sum=0

while [ $Num -gt 0 ]
  do
    # get Remainder 
    k=$(( $Num % 10 ))  

    # get next digit 
    Num=$(( $Num / 10 )) 

    # calculate sum of 
    # digit   
    Sum=$(( $Sum + $k ))
done

echo "Sum of the digits of $n is : $Sum"