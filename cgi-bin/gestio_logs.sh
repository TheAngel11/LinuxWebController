#!/bin/bash
echo -e "Content-type: text/plain\n"
data=$(cat) #read data
logger -t ASO_LOGS "S'ha accedit a la gestio de logs del sistema."
file_filtrat=`grep -a ASO_LOGS /var/log/sys.log`
echo "$file_filtrat" #return data
exit 0 