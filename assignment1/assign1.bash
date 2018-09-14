#!/bin/bash
#Check for data directory to create
dirCount=$(find . -name data | wc -l)
if [[ dirCount -eq 0 ]]; then
    mkdir data
fi

# Create the menu for user input
go=0
while [ $go ]; do
    echo "Enter one of the follow actions or press CTRL-D to exit."
    echo "C - create a new item"
    echo "R - read an existing item"
    echo "U - update an existing item"
    echo "D - delete an existing item"
    if ! read input; then
        # Reached EOF
        break
    fi
    case "$input" in
        [Cc])
            bash create.bash
            ;;
        [Rr])
            bash read.bash
            ;;
        [Uu])
            bash update.bash
            ;;
        [Dd])
            bash delete.bash
            ;;
        *) echo "ERROR: invalid option"
    esac
done
