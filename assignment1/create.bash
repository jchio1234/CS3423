#!/bin/bash
read iNum
read sName
read iName
read cQuan
read mQuan
read desc

cd data
#Check if a file already exists
if [[ -e $iNum.item  ]]; then
    echo "ERROR: item already exists"
else
    cat > $iNum.item << EOF
${sName} ${iName}
${cQuan} ${mQuan}
${desc}
EOF
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
