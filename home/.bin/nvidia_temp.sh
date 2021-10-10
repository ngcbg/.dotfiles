#!/bin/bash

#NVD_TEMP=$(nvidia-smi | grep GeForce -A 1 | awk '{ print $3 }' | tail +2 | sed 's/C//g'| sed -ne 's/$/° &/p')
NVD_TEMP=$( nvidia-smi -q | grep 'GPU Current Temp' -A 0 | awk '{ print $5 }' | sed 's/C//g' )
#CPU_FAN=$(sensors | grep fan1 | awk '{ print $2" "$3}')
#echo $NVD_TEMP >> /opt/NVD_TEMP.out
#feh ~/Documents/nvidia-scalled2.png
printf "%s" "$NVD_TEMP"
