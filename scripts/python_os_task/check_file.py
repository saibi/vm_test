#!/usr/bin/python3

import os
path = "/tmp/testfile.txt"
if os.path.exists(path):
    print("File exists")
else:
    print("File does not exist")
