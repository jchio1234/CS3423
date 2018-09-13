#!/bin/bash
iNum=$1
sName=$2
iName=$3
cQuan=$4
mQuan=$5
des=$6

cd ./data

cat > $iNum.item << 'EOF'
"$sName" "$iName"
"$cQuan" "$mQuan"
"$des"
EOF

cd ..
