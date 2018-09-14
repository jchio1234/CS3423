#1/bin/bash
read -p "Enter an item number: " iNum

#Keep prompting for iNum if it is empty
while [[ -z "$iNum" ]]; do
    read -p "Enter an item number: " iNum
done

#Continue checking for input and flag empty inputs
read -p "Enter a simple name: " sName
if [[ -z "$sName" ]]; then
    sName=emptyinput
fi

read -p "Enter an item name: " iName
if [[ -z "$iName" ]]; then
    iName=emptyinput
fi

read -p "Enter a current quantity: " cQuan
if [[ -z "$cQuan" ]]; then
    cQuan=emptyinput
fi

read -p "Enter a maximum quantity: " mQuan
if [[ -z "$mQuan" ]]; then
    mQuan=emptyinput
fi

read -p "Enter a description: " desc
if [[ -z "$desc" ]]; then
    desc=emptyinput
fi

#Check if a file with that item number exists
cd data
if [[ -e $iNum.item ]]; then
    fileName=$iNum.item
    #Loop through the file and grab the contents
    for (( i=1;; i++)); do
        read "line$i" || break;
    done < $fileName

    #Iterate through each line and grab the values
    read osName oiName <<< $line1
    read ocQuan omQuan <<< $line2

    #Check for empty input and replace if needed
    if [[ "$sName" = "emptyinput" ]]; then
        sName=$osName
    fi

    if [[ "$iName" = "emptyinput" ]]; then
        iName=$oiName
    fi

    if [[ "$cQuan" = "emptyinput" ]]; then
        cQuan=$ocQuan
    fi

    if [[ "$mQuan" = "emptyinput" ]]; then
        mQuan=$omQuan
    fi

    if [[ "$desc" = "emptyinput" ]]; then
        desc=$line3
    fi

    #Update the item file
    cat > $iNum.item << EOF
${sName} ${iName}
${cQuan} ${mQuan}
${desc}
EOF

    #Update the log
    if [[ -e queries.log ]]; then
        cat >> queries.log << EOF
UPDATED: ${sName} - $(date)
EOF
    else
        cat > queries.log << EOF
UPDATED: ${sName} - $(date)
EOF
    fi
else
    echo "ERROR: item not found";
fi
cd ..
