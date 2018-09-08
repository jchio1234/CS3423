#!/bin/bash
go=0
while [ $go ]; do
    echo "Enter your choice or CTRL-D"
    echo "A - I want to get an A"
    echo "B - I want to get a B"
    echo "F - I give up"
    if ! read ans; then
        #Reached EOF
        Break
    fi
    case "$ans" in
        A) echo "you got an A"
            break
            ;;
        B) echo "you can do better than a B"
            ;;
        F) echo "keep trying"
            ;;
        *) echo "we think you can type better than that"
    esac
done
