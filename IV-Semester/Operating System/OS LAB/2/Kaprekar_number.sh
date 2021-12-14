#! /bin/bash

read -p "Enter the Number : " n
if [ $n -eq 1 ]
then 
    echo "1 is a Kaprekar Number!"
else
    sq_n=$(($n * $n))
    count_digits=0
    while [ $sq_n -gt 0 ]
        do
            ((count_digits++))
            sq_n=$(( $sq_n / 10 ))
    done
    sq_n=$(( $n * $n ))
    flag=0
    pow_ten=1
    tmp=1
    while [ $tmp -lt $count_digits ]
        do
            pow_ten=$(( $pow_ten * 10 ))
            if [ $pow_ten -eq $n ]
            then
                continue
            fi
            sum=$((($sq_n / $pow_ten) + ($sq_n % $pow_ten)))
            if [ $sum -eq $n ]
            then
                flag=1
            fi
            ((tmp++))

    done
    if [ $flag -gt 0 ]
    then
        echo "$n is a Kaprekar Number!"
    else
        echo "$n is NOT a Kaprekar Number!"
    fi
fi