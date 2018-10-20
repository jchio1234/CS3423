#!/bin/bash

#Delete lines that don't start with the valid format CCDDDD
sed -E -f startsvalidformat.sed p4.txt > p4Fix.txt

#Delete lines that don't end with Spring 2018
sed -E -f endswith.sed p4Fix.txt > p4EndFix.txt

#Print second field and third field seperated by a colon
sed -E -f formatprint.sed p4EndFix.txt

rm p4Fix.txt
rm p4EndFix.txt
