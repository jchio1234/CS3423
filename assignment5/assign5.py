#!/usr/bin/env python3

import sys
import os
import re


#Return a list of '.item' files from the given directory
def list_item_files(directory):
    file_list = []
    for file in os.listdir(directory):
        if file.endswith('.item'):
            file_list.append(file)
    return file_list


#Return a list of files that require processing (inventory less than 10%)
def list_files_to_process(files_list):
    files_to_process = []
    for file in files_list:
        with open(data_dir + '/' + file, 'r') as f:
            line_num = 0
            for line in f:
                line_num += 1
                if line_num == 2:
                    info = re.match(r"(?P<current_quant>\d+)\s+(?P<max_quant>\d+)", line)
                    if check_for_invalid_inventory(info['current_quant'], info['max_quant']):
                        files_to_process.append(f)
    return files_to_process


#Returns true if inventory for the current item is less than 10%
def check_for_invalid_inventory(current_quant_string, max_quant_string):
    inventory_percentage = int(current_quant_string) / int(max_quant_string) * 100
    if inventory_percentage < 10:
        return True
    return False

#Process files
def process_files(file_list):
    for file in file_list:
        with open(data_dir + '/' + file, 'r') as f:
            print('Time to process!')

#Verify that the user entered the minimum number of arguments or exit with usage message
if len(sys.argv) < 5:
    print("Error: Not enough arguments")
    print("Usage: [python file] [data directory] [template file] [date] [output directory]")
    sys.exit(1)

#Check if output directory exists or create it
if not os.path.exists(sys.argv[4]):
    os.mkdir(sys.argv[4])

#Check for extra credit args
if len(sys.argv) > 5:
    left_char = sys.argv[5]
    right_char = sys.argv[6]
else:
    left_char = '<<'
    right_char = '>>'

#Create variables for arguments for readability
data_dir = sys.argv[1]
template = sys.argv[2]
g_date = sys.argv[3]

#Get all files in data directory
all_files = list_item_files(data_dir)

#Get a list of files to process
files_to_process = list_files_to_process(all_files)

#Process the files and produce the output files
for file in files_to_process:
    print('File: ' + os.path.basename(file.name) + ' will be processed!')