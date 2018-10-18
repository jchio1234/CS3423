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
        for(( i=1;;i++ )); do
            read "line$i" || break;
        done < $filename
        
        #Store the variables
        read sName iName <<< $line1
        read cQuan mQuan <<< $line2
        
        echo "Simple name: $sName"
        echo "Item name: $iName"
        echo "Current quant: $cQuan"
        echo "Max quant: $mQuan"
        echo "Body: $line3"
        echo ""
done
