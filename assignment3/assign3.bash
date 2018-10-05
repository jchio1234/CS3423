#!/bin/bash
cdate=$(date --date='Aug 16 2018 23:05')
gawk -f program.awk ${1} -v date="$cdate"
