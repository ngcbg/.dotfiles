#!/bin/bash

loadav=$(uptime | grep -ohe 'load average[s:][: ].*' | awk '{ print $3" "$4" "$5"," }' | sed 's/,//g')
#echo $loadav
#printf '%s\t%s\t%s' $loadav | sed 's/,//g'
printf '%s  %s  %s' $loadav

