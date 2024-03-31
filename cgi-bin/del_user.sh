#!/bin/bash
echo -e "Content-type: text/plain\n"
data=$(cat) #read data
# Data (json) is the username
username=`echo $data | awk -F ":" '{print $2}' | awk -F "," '{print $1}' | awk -F '"' '{print $2}'`

# Delete user
userdel -r $username

# Adding to the syslog the deletion of the user.
#logger -t ASO_LOGS "S'ha eliminat l'usuari $username correctament."
exit 0 