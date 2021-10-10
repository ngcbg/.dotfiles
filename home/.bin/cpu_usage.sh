#!/bin/bash

# Print Free CPU resources in %


CPU_IDLE=$(top -b -n2 -p 1 | fgrep "Cpu(s)" | tail -1 | awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); printf "%s%.1f%%\n", prefix, 100 - v }')

#DATE=$(date "+%Y-%m-%d %H:%M:")
#CPU_USAGE="$DATE CPU: $CPU_USAGE"
#echo $CPU_USAGE >> /opt/cpu_usage.out

echo " " $CPU_IDLE
#\item icon.+[.]png" 
#\1
