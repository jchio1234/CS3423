#!/bin/bash
read -p "Enter an item number: " iNum

#Check if a file exists
fileCount=$(find ./data -name $iNum.item | wc -l)
if [[ fileCount -gt 0 ]]; then
    fileName=$iNum.item
    for (( i=1;; i++)); do
        read "line$i" || break;
    done < ./data/$fileName
    while read $line1; do
        read sName iName
    done
    while read $line2; do
        read cQuan mQuan
    done
    echo "Item name: $iName"
    echo "Simple name: $sName"
    echo "Item Number: $iNum"
    echo "Qty: $cQuan/$mQuan"
    echo "Description: $line3"
else
    echo "ERROR: item not found"
fi
