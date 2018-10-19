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

#Store the name of the template file
template=$2

#Check for output directory and create if needed
output_dir=$4
if [[ ! -d $output_dir ]]; then
    mkdir $output_dir;
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
       
        gawk -f assign4.awk -v fName="$filename" -v sName="$sName" -v iNa\me="$iName" -v cQuan="$cQuan" -v mQuan="$mQuan" -v body="$line3" $template
done
