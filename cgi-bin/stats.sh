#!/bin/bash
echo -e "Content-type: text/plain\n"
data=$(cat) #read data
proces=`ps -aux`
echo "$proces" #return data
logger -t ASO_LOGS "S'ha accedit a la gestio de processos del sistema."
exit 0