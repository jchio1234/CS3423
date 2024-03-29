#!/bin/bash
#Check for extra inputs and adjust characters to search for
if [[ $# -gt 4 ]]; then
    {
        left_char=$5
        right_char=$6
        extra_credit="true"
    }
else
    {
        left_char="<<"
        right_char=">>"
        extra_credit="false"
    }
fi

#Store the name of the template file
template=$2

#Store the date
g_date=$3

#Check for output directory and create if needed
output_dir=$4
if [[ ! -d $output_dir ]]; then
    mkdir $output_dir;
fi

#Iterate through each ".item" file in the given directory
files="$1/*.item"
for filename in $files; do
    [ -e "$filename" ] || continue
        for(( i=1;;i++ )); do
            read "line$i" || break;
        done < $filename
        
        #Store the variables
        read sName iName <<< $line1
        read cQuan mQuan <<< $line2
        
        #Pass variables into awk script
        gawk -f assign4.awk -v fName="$filename" -v sName="$sName" -v iName="$iName" \-v cQuan="$cQuan" -v mQuan="$mQuan" -v body="$line3" -v l_char="$left_char" -v r_char\="$right_char" -v g_date="$g_date" -v template="$template" -v extra_credit="$extra_credit" $template
done

#Iterate through all sed files
sed_files="*.sed"
for sed_file in $sed_files; do
    item_num=`echo $sed_file | sed "s/\.sed//g"`
    item_out="$item_num.out"
    sed -E -f $sed_file $template > $output_dir/$item_out
    rm $sed_file
done
