#!/bin/bash

file=$1
start=$2
end=$3

#Check for correct number of arguments
if [[ "$#" -ne 3 ]]; then
    echo "Enter "$0" 'path' 'start' 'end'"
fi

#If start is < 1, set to 1
if [[ start -lt 1 ]]; then
    start=1
fi

#If end is > number of lines, print to EOF
count=0
while read line; do
    let count+=1
done < $file

if [[ end -gt $count ]]; then
    end=$count
fi

sed -n "$start,$end p" $file
