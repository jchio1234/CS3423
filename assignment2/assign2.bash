#!/bin/bash

#Name of the file is stored in $1

#Remove trailing whitespace after a line
sed -E -f trailingwhitespace.sed ${1} > debug

#No more than one space between tokens
sed -E -f spacebetweentokens.sed ${1} > debug

