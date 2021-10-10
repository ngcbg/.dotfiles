#!/bin/bash
BL="\e[033;1;34m"
YE="\e[0;33;33m"
MG="\e[0;35;35m"
RD="\e[0;31;31m"
WT="\e[0;37;37m"

red=`tput setaf 1`
yellow=`tput setaf 3`
mag=`tput setaf 5`
blue=`tput setaf 6`
reset=`tput sgr0`

CPU_TEMP=$(sensors | grep Tdie | awk '{ print $2 }' | sed s/+//g )

TEMP1=25
TEMP2=35
TEMP3=45
TEMP4=55

while [ $CPU_TEMP -gt '10' ]; do
 
	if [ $(echo $CPU_TEMP | sed 's/....$//g') -lt $TEMP1 ]; then
		echo ${blue}"  "$WT $CPU_TEMP
		exit 0
	fi
	
	if [ $(echo $CPU_TEMP | sed 's/....$//g') -lt $TEMP2 -a $(echo $CPU_TEMP | sed 's/....$//g') -gt $TEMP1 ]; then
		echo ${yellow}"  " $CPU_TEMP
		exit 0
	fi
	
	if [ $(echo $CPU_TEMP | sed 's/....$//g') -lt $TEMP3 -a $(echo $CPU_TEMP | sed 's/....$//g') -gt $TEMP2 ]; then
		echo ${mag}"  "$WT $CPU_TEMP
		exit 0
    fi
    
	if [ $CPU_TEMP -lt $TEMP4 -a $CPU_TEMP -gt $TEMP3 ]; then
		echo ${red}"  "$WT $CPU_TEMP
		exit 0
		end
	fi
	
	if [ $CPU_TEMP -gt $TEMP4 ]; then
		echo -e $RD"  "$CPU_TEMP
		exit 0
		end
	fi
	
done
