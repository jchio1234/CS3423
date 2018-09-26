#!/bin/bash

#Name of the file is stored in $1

#Remove trailing whitespace after a line
sed -E -f trailingwhitespace.sed ${1} > debug

#Remove extra whitespace between binary operators

