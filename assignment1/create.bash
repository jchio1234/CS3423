#!/bin/bash
read iNum
read sName
read iName
read cQuan
read mQuan
read desc

cd data
#Check if an item file exists
if [[ -e $iNum.item  ]]; then
    echo "ERROR: item already exists"
else
    #Create the item file
    cat > $iNum.item << EOF
${sName} ${iName}
${cQuan} ${mQuan}
${desc}
EOF
    #Check if log file exists to either create or append
    if [[ -e queries.log ]]; then
        cat >> queries.log << EOF
CREATED: ${sName} - $(date)
EOF
    else
        cat > queries.log << EOF
CREATED: ${sName} - $(date)
EOF
    fi
fi
cd ..
