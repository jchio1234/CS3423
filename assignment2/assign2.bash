#!/bin/bash

#Name of the file is stored in $1

#Print lines that don't start with a single line comment
echo "Printing lines that don't start with a single line comment"
sed -n -f singleline.sed ${1}

#Print lines that don't start with a multi line comment
echo "Printing lines that don't start with a multi line comment"
sed -n -f multiline.sed ${1}
