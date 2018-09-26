#!/bin/bash

#Name of the file is stored in $1

#Remove trailing whitespace after a line
echo "Remove trailing whitespace after a line"
sed -E -f trailingwhitespace.sed ${1} > output.c

#Remove extra whitespace between binary operators
echo "Printing lines that don't start with a multi line comment"
