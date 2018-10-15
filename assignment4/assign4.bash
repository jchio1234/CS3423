#!/bin/bash
#Check for a 5th and 6th input and adjust the surrounding characters
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
echo "Given directory is: $1"
files="$1/*.item"
echo "Expanded directory is $files"
for filename in $files; do
    [ -e "$filename" ] || continue
    echo "Filename is: $filename"
done
