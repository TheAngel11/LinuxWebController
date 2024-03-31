#!/bin/bash
echo -e "Content-type: text/plain\n"
data=$(cat) #read data

# List all users in the system (from /etc/passwd) that have a home directory
users=`cat /etc/passwd | grep /home | awk -F: '{print $1}'`

echo "$users" #return users
exit 0 