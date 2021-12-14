#! /bin/bash

happy_number()
    {   var2=$1
        declare -i sum
        sum=0
        while [ $var2 -gt 0 ]
            do
                dig=$(( $var2 % 10 ))
                sum=$(( $sum + ($dig * $dig) ))
                var2=$(( $var2 / 10 ))
            done
        return $sum
    }
read -p "Enter the number : " N    
var=$N
while [ $var != 1 -a $var != 4 ]
    do
        happy_number $var
        var=$?
    done
if [ $var == 1 ]
    then
        echo "Happy Number !"
else
    echo "Not a Happy Number !"
fi
