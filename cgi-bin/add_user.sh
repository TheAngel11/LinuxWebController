#!/bin/bash
echo -e "Content-type: text/plain\n"
data=$(cat) #read data
# The first position of the data (json) is the username, and the second is the password.
username=`echo $data | awk -F ":" '{print $2}' | awk -F "," '{print $1}' | awk -F '"' '{print $2}'` 
password=`echo $data | awk -F ":" '{print $3}' | awk -F "," '{print $1}' | awk -F '"' '{print $2}'`

# We check if the user already exists by checking if the username is in the /etc/passwd file.
userExists=`awk -F ":" '{print $1}' /etc/passwd | grep -x "$username"`
if [ -z "$userExists" ]
then
    
    # We add the user to the system.
    sudo useradd -m -p $(openssl passwd -6 $password) $username
    echo '$username:PASSWORD' | chpasswd --crypt-method SHA512 
    # We set the password to the user.
    #sudo echo "$username:$password" | chpasswd --crypt-method SHA512 
    echo "L'usuari s'ha creat correctament."
    # Adding to the syslog the correct creation of the user.
    logger -t ASO_LOGS "S'ha creat l'usuari $username correctament."
else 
    echo "L'usuari ja existeix."
    # Adding to the syslog the incorrect creation of the user.
    logger -t ASO_LOGS "S'ha intentat crear l'usuari $username, però ja existeix."
fi

exit 0 