#!/bin/bash
# Check for directory or create
if [ -d "./data" ]; then
    echo "Directory /data exists!"
else
    echo "Directory /data does not exist!"
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
            echo "Time to create a new item!"
            bash create.bash
            ;;
        [Rr])
            echo "Time to read an existing item!"
            ;;
        [Uu])
            echo "Time to update an existing item!"
            ;;
        [Dd])
            echo "Time to delete an existing item!"
            ;;
        *) echo "Please enter a valid command"
    esac
done
