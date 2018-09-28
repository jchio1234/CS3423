#!/bin/bash

#Remove trailing whitespace after a line
sed -E -f trailingwhitespace.sed ${1} > debug.c

#Remove extra whitespace around binary operators
sed -E -f spacebetweenoperators.sed debug.c > debug2.c

#Remove extra whitespace around binary operators
sed -E -f spacebetweentokens.sed debug2.c > debug3.c

#Remove extra whitespace inside of parentheses
sed -E -f spaceinconditions.sed debug3.c

#Remove debug files
rm debug.c
rm debug2.c
rm debug3.c
