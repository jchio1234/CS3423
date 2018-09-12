#!/bin/bash
go=0
while [ $go ]; do
    echo "Enter one of the following actions or press CTRL-D to exit."
    echo "C - create a new item"
    echo "R - read an existing item"
    echo "U - update an existing item"
    echo "D - delete an existing item"
    if ! read ans; then
        # got EOF
        Break
    fi
    case "$ans" in
        [Cc]) echo "time to create a new item!"
            ;;
        [Rr]) echo "time to read an existing item!"
            ;;
        [Uu]) echo "time to update an existing item!"
            ;;
        [Dd]) echo "time to delete an existing item!"
            ;;
        *) echo "Please enter a valid command"
    esac
done
