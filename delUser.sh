#!/bin/bash
echo -e "Content-type: text/plain\n"
data=$(cat) #read data
#logger -t ASO_LOGS "S'ha accedit a la gestio de logs del sistema."
echo "$data" #return data
exit 0 