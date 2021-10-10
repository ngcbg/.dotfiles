#!/bin/bash

mem_used=$(free -m | grep Mem | awk '{ print $3 }')
mem_tot=$(free -m | grep Mem | awk '{ print $2 }')
mem_used_p=$(echo "100/$mem_tot*$mem_used"|bc -l | cut -c -4)
#printf "%s" " " $mem_used_p"%""  "$mem_used "Mb"
printf "%s" $mem_used_p"%"" - "$mem_used "Mb"
#printf '%s' "$mem_used_p""%" "$mem_used" "Mb"
