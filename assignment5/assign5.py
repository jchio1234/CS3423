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
    print("Left char: " + left_char)
    print("Right char: " + right_char)
else:
    left_char = '<<'
    right_char = '>>'
    print("Left char: " + left_char)
    print("Right char: " + right_char)

#Store the name of the template file
template = sys.argv[2]
print("Template is: " + template)

#Store the date
g_date = sys.argv[3]
print("Date is: " + g_date)
