#!/bin/bash
read iNum
read sName
read iName
read cQuan
read mQuan
read desc

#Check if a file already exists
fileCount=$(find ./data -name $iNum.item | wc -l)
if [[ fileCount -gt 0 ]]; then
    echo "ERROR: item already exists"
else
    cd data
    
    cat > $iNum.item << EOF
${sName} ${iName}
${cQuan} ${mQuan}
${desc}
EOF
    
    logCount=$(find . -name queries.log | wc -l)
    if [[ logCount -gt 0 ]]; then
        cat >> queries.log << EOF
CREATED: ${sName} - $(date)
EOF
    else
        cat > queries.log << EOF
CREATED: ${sName} - $(date)
EOF
    fi
    cd ..
fi
