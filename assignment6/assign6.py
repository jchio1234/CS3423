#!/usr/bin/env python3

import sys
import os
import re
import shutil
import zipfile


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
    with zipfile.ZipFile(current_directory + '/' + zip_assignment + '.zip', 'w') as new_zip:
        for file in files_in_directory:
            new_zip.write(file)


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
if zip_assignment:
    print('EC is defined!')
else:
    print('EC is not defined!')
all_files = os.listdir(current_directory)

# Iterate through each file in the directory
for file in all_files:
    suffix = re.match(r'proj([\w]*).', file)
    # If file has valid suffix, create the appropriate directory and move the file
    if suffix:
        dir_name = create_directory(suffix.group(1))
        shutil.move(current_directory + '/' + file, dir_name)
        if zip_assignment and zip_assignment == suffix.group(1):
            create_zip_directory(dir_name)
    # If the file does not have a valid suffix, create 'misc' directory and move the file
    else:
        misc_dir = create_misc_directory()
        shutil.move(current_directory + '/' + file, misc_dir)

