#!/bin/bash
echo -e "Content-type: text/plain\n"
data=$(cat) #read data


#check if there are usb connected (so there are 2 disks in bus 001)
found=`lsusb | grep -c 'Bus 001'`
if [ $found -eq 2 ]
then
    #get the name of the usb partition
    partition=`sudo fdisk -l | tail -n 1 | awk '{print $1}'`
    #mount the usb partition
    sudo mount $partition /mnt/usb
    if [ $? -eq 0 ]
    then
        echo "OK"     

        cd
        #delete files from usb folder
        sudo rm -rf /srv/www/GlobalVars/usb/*
        #copy files from usb mount to usb folder
        sudo cp -r /mnt/usb/* /srv/www/GlobalVars/usb

        #unmount and delete files from usb partition
        sudo umount /mnt/usb
        sudo rm -rf /mnt/usb/*

        cd /srv/www/GlobalVars/usb

        #get the list of files in the usb folder 
        ls=`ls`  

        #create a file with the list of files in the usb folder
        sudo touch llistat.txt
        sudo chmod 777 llistat.txt
        echo "Title         Path" > llistat.txt 
  
        while read -r line
        do            
            #find the path of the file
            path=`sudo find / -name "$line"`
            sudo echo "$line         $path" >> llistat.txt
            if [ "$line" != "SYS" ] && [ "$line" != "System Volume Information" ]
            then
                echo $line
            fi        done <<< "$ls"  

        logger -t ASO_LOGS "S'ha muntat el dispositiu USB correctament."       

    else
        echo "ERROR: error al montar la carpeta /mnt/usb."
        logger -t ASO_LOGS "S'ha intentat muntar el dispositiu USB sense èxit."    
    fi
    
else
    echo "ERROR: No s'ha trobat cap dispositiu USB. v2"
fi  

exit 0