#!/usr/bin/env python3

import sys
import os
import re
import shutil


# Create directory if it does not exist
def create_directory(directory_suffix):
    temp_dir_name = current_directory + '/assignment' + directory_suffix
    if not os.path.isdir(temp_dir_name):
        os.mkdir(temp_dir_name)
    return temp_dir_name


# Create 'misc' directory if it does not exist
def create_misc_directory():
    temp_dir_name = current_directory + '/misc'
    if not os.path.isdir(temp_dir_name):
        os.mkdir(temp_dir_name)
    return temp_dir_name


# Create the zip directory specified by optional argument
def create_zip_directory(directory_name):
    files_in_directory = os.listdir(directory_name)


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

# Get the optional argument if it exists
if len(sys.argv) > 2:
    zip_assignment = sys.argv[2]
else:
    zip_assignment = None

# Get all files in the directory
all_files = os.listdir(current_directory)

# Iterate through each file in the directory
for file in all_files:
    suffix = re.match(r'(proj)([\w]*).', file)
    # If file has valid suffix, create the appropriate directory and move the file
    if suffix and suffix.group(1) and suffix.group(2):
        dir_name = create_directory(suffix.group(2))
        shutil.move(current_directory + '/' + file, dir_name)
        if zip_assignment and zip_assignment == suffix.group(2):
            create_zip_directory(dir_name)
    # If file does not have a valid suffix, create 'assignment' directory and move the file
    elif suffix and suffix.group(1) and not suffix.group(2):
        dir_name = create_directory('')
        shutil.move(current_directory + '/' + file, dir_name)
    # If the file does not have a valid prefix or suffix, create 'misc' directory and move the file
    else:
        misc_dir = create_misc_directory()
        shutil.move(current_directory + '/' + file, misc_dir)

