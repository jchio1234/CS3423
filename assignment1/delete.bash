#!/bin/bash
read -p "Enter an item number: " iNum

#Check if an item file exists
cd data
if [[ -e $iNum.item ]]; then
    fileName=$iNum.item
    
    #Get the first line and simple name
    read firstLine < $fileName
    read sName iName <<< $firstLine

    #Remove the file
    rm $fileName

    #Check if log file exists to either create or append
    if [[ -e queries.log ]]; then
        cat >> queries.log << EOF
DELETED: $sName - $(date)
EOF
    else
        cat > queries.log << EOF
DELETED: $sName - $(date)
EOF
    fi
    echo "$sName was successfully deleted."
else
    echo "ERROR: item not found"
fi
cd ..
