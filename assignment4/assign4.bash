#!/bin/bash
#Check for extra inputs and adjust characters to search for
if [[ $# -gt 4 ]]; then
    {
        left_char=$5
        right_char=$6
        echo "left_char = $left_char"
        echo "right_char = $right_char"
    }
else
    {
        left_char="<<"
        right_char=">>"
        echo "left_char = $left_char"
        echo "right_char = $right_char"
    }
fi

#Iterate through each file in the given directory
files="$1/*.item"
for filename in $files; do
    [ -e "$filename" ] || continue
    echo "Filename is: $filename"
    #To-Do: Get the relevant data from each file and check for the 10% value
done
