#!/bin/bash
echo -e "Content-type: text/plain\n"
data=$(cat) #read data

# Sending the CPU usage
cpu_usage=`awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' \
<(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)`

echo "$cpu_usage"

# Sending the cpu load 
cpu_load=`uptime | awk -F "load average: " '{print $2}'`
echo "$cpu_load"

# Sending the memory usage
mem_total=`free -h | awk 'NR==2 {print $2}'`
echo "$mem_total"
mem_used=`free -h | awk 'NR==2 {print $3}'`
echo "$mem_used"

# Senting memory percentage
mem_total_megas=`free -m | awk 'NR==2 {print $2}'`
mem_used_megas=`free -m | awk 'NR==2 {print $3}'`
let mem_percentage=100*$mem_used_megas/$mem_total_megas
echo "$mem_percentage%"

# Sending the disk usage
disk_total=`df -h | awk 'NR==2 {print $2}'`
echo "$disk_total"
disk_used=`df -h | awk 'NR==2 {print $3}'`
echo "$disk_used"

# Sending the disk percentage
disk_total_megas=`df -m | awk 'NR==2 {print $2}'`
disk_used_megas=`df -m | awk 'NR==2 {print $3}'`
let disk_percentage=100*$disk_used_megas/$disk_total_megas
echo "$disk_percentage%"

# Sending the time running of the system
time_running=`uptime | awk -F "up " '{print $2}' | awk -F "," '{print $1}'`
echo "$time_running"

# Sending the date of the last 10 logins
last_logins=`grep -a "Accepted password" /var/log/auth.log | tail -n 10 | awk '{print $1, $2, $3}'`
echo "$last_logins"

# Adding to the syslog the access to the system monitoring
logger -t ASO_LOGS "S'ha accedit a la monitoritzacio del sistema."
exit 0 