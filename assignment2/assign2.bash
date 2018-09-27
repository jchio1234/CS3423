#!/bin/bash

#Name of the file is stored in $1

#Remove trailing whitespace after a line
sed -E -f trailingwhitespace.sed ${1} > debug.c

#No more than one space between tokens
sed -E -f spacebetweentokens.sed debug.c > debug2.c

#Remove extra whitespace around binary operators

