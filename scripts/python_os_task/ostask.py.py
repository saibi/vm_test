#!/usr/bin/python3

import os

userlist = ["alpha", "saibi", "gamma", "vagrant"]

for user in userlist:
    exitcode = os.system("id " + user + " &> /dev/null")
    if exitcode == 0:
        print("User " + user + " exists")
    else:
        print("User " + user + " does not exist")
