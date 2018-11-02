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
                    info = re.match(r'(\d+)\s+(\d+)', line)
                    if check_for_invalid_inventory(info.group(1), info.group(2)):
                        files_to_process.append(f)
    return files_to_process


#Returns true if inventory for the current item is less than 10%
def check_for_invalid_inventory(current_quant_string, max_quant_string):
    inventory_percentage = int(current_quant_string) / int(max_quant_string) * 100
    if inventory_percentage < 10:
        return True
    return False


#Substitue simple_name variable
def process_simple_name(s_name, string):
    s_name_variable = left_char + 'simple_name' + right_char
    processed_s_name = re.sub(s_name_variable, s_name, string)
    return processed_s_name


#Substitute item_name variable
def process_item_name(i_name, string):
    i_name_variable = left_char + 'item_name' + right_char
    processed_i_name = re.sub(i_name_variable, i_name, string)
    return processed_i_name


#Substitute current_quantity variable
def process_current_quantity(c_quan, string):
    c_quan_variable = left_char + 'current_quantity' + right_char
    processed_c_quan = re.sub(c_quan_variable, c_quan, string)
    return processed_c_quan


#Substitute max_quantity variable
def process_max_quantity(m_quan, string):
    m_quan_variable = left_char + 'max_quantity' + right_char
    processed_m_quan = re.sub(m_quan_variable, m_quan, string)
    return processed_m_quan

#Substitute body variable
def process_body(body, string):
    body_variable = left_char + 'body' + right_char
    processed_body = re.sub(body_variable, body, string)
    return processed_body

#Substitute date variable
def process_date(string):
    date_variable = left_char + 'date' + right_char
    processed_date = re.sub(date_variable, g_date, string)
    return processed_date


#Create the output file
def create_output_file(output_file, lines_to_write):
    with open(output_file, 'a') as outfile:
        for line in lines_to_write:
            outfile.write(line)

#Creates the '.output' file
def process_lines(file_name, s_name, i_name, c_quan, m_quan, body):
    item = re.match(r'.*(\d\d\d\d)\.item', file_name)
    output_file_name = item.group(1) + '.item'
    output_directory = output_dir + '/' + output_file_name
    lines_to_write = []

    #Open the template file and read in one line at a time
    with open(template, 'r') as template_file:
        for line in template_file:
            simple_name = process_simple_name(s_name, line)
            item_name = process_item_name(i_name, simple_name)
            current_quantity = process_current_quantity(c_quan, item_name)
            max_quantity = process_max_quantity(m_quan, current_quantity)
            p_body = process_body(body, max_quantity)
            p_date = process_date(p_body)
            lines_to_write.append(p_date)

    create_output_file(output_directory, lines_to_write)

#Process files
def process_files(file_list):
    name = {}
    item = {}
    body = {}
    for file in file_list:
        with open(file.name, 'r') as f:
            line_num = 0
            for line in f:
                line_num += 1
                if line_num == 1:
                    name = re.match(r'(\w+)\s+(.+)', line)
                if line_num == 2:
                    item = re.match(r'(\d+)\s+(\d+)', line)
                if line_num == 3:
                    body = re.match(r'^[^\n]*$', line)
        process_lines(f.name, name.group(1), name.group(2), item.group(1), item.group(2), body.group(0))

#Verify that the user entered the minimum number of arguments or exit with usage message
if len(sys.argv) < 5:
    print('Error: Not enough arguments')
    print('Usage: [python file] [data directory] [template file] [date] [output directory]')
    sys.exit(1)

#Check if output directory exists or create it
if not os.path.exists(sys.argv[4]):
    os.mkdir(sys.argv[4])

#Check for extra credit args
if len(sys.argv) > 5:
    left_char = re.escape(sys.argv[5].replace("'", ""))
    right_char = re.escape(sys.argv[6].replace("'", ""))
else:
    left_char = '<<'
    right_char = '>>'

#Create variables for arguments for readability
data_dir = sys.argv[1]
template = sys.argv[2]
g_date = sys.argv[3]
output_dir = sys.argv[4]

#Get all files in data directory
all_files = list_item_files(data_dir)

#Get a list of files to process
files_to_process = list_files_to_process(all_files)

#Process the files and produce the output files
process_files(files_to_process)
