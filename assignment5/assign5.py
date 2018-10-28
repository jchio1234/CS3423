#!/usr/bin/env python3

import sys
import os

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

data_dir = sys.argv[1]
template = sys.argv[2]
g_date = sys.argv[3]

#Iterate over the ".item" files in the directory
for file in os.listdir(data_dir):
    if file.endswith('.item'):
        with open(data_dir + '/'+ file, 'r') as f:
            line_num = 0
            for line in f:
                line_num += 1
                print('File: ' + file + ' Line #: ' + str(line_num))
                #words = line.split():
                

