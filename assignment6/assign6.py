#!/usr/bin/env python3

import sys
import os
import re
import shutil


# Create directory if it doesn't exist
def check_if_directory_exists(directory_suffix):
    temp_dir_name = current_directory + '/assignment' + directory_suffix
    if not os.path.isdir(temp_dir_name):
        os.mkdir(temp_dir_name)
    return temp_dir_name

# Move the file to the specified directory
def move_file(file, dir):
    shutil.move(file, dir)

# Verify the correct number of arguments
if len(sys.argv) < 2:
    print('Error: Not enough arguments')
    print('Usage: [python file] [directory path]')
    sys.exit(1)

# Check if directory argument is actually a directory
if not os.path.isdir(sys.argv[1]):
    print('Error: ' + sys.argv[1] + ' is not a directory')
    print('Please enter a valid directory and try again')
    sys.exit(2)

# Get the directory argument
current_directory = sys.argv[1]

# Get all files in the directory
all_files = os.listdir(current_directory)
print('Number of files in ' + current_directory + ' is: ' + str(len(all_files)))


# Iterate through each file in the directory
for file in all_files:
    suffix = re.match(r'proj([\w]*).', file)
    if suffix:
        print('File name is: ' + file)
        print('Suffix of this file is: ' + suffix.group(1))
        dir_name = check_if_directory_exists(suffix.group(1))
        #move_file(file, dir_name)
