#!/bin/bash

CPU_TEMP=$(sensors | grep Tdie | awk '{ print $2 }' | sed s/+//g | sed s/C//g)
#CPU_FAN=$(sensors | grep fan1 | awk '{ print $2" "$3}')
#sensors | grep Tdie | awk '{ print $2 }' | sed s/+//g | sed 's/....$//g'
#echo $CPU_TEMP >> /opt/CPU_TEMP.out

#echo "   "$CPU_TEMP" " " ""  "$CPU_FAN
#echo $CPU_TEMP""
printf "%s" "  " $CPU_TEMP
