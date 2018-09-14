#!/bin/bash
read -p "Enter an item number: " iNum

#Check if a file exists
cd data
if [[ -e $iNum.item ]]; then
    fileName=$iNum.item
    for (( i=1;; i++)); do
        read "line$i" || break;
    done < $fileName
    
    read sName iName <<< $line1
    
    read cQuan mQuan <<< $line2
    
    echo "Item name: $iName"
    echo "Simple name: $sName"
    echo "Item Number: $iNum"
    echo "Qty: $cQuan/$mQuan"
    echo "Description: $line3"
else
    echo "ERROR: item not found"
fi
cd ..
