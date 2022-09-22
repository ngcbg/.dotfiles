#!/bin/bash

#NVD_TEMP=$(nvidia-smi | grep GeForce -A 1 | awk '{ print $3 }' | tail +2 | sed 's/C//g'| sed -ne 's/$/° &/p')
#NVD_TEMP=$( nvidia-smi -q | grep 'GPU Current Temp' -A 0 | awk '{ print $5 $6 }')
#CPU_FAN=$(sensors | grep fan1 | awk '{ print $2" "$3}')
#echo $NVD_TEMP >> /opt/NVD_TEMP.out
#feh ~/Documents/nvidia-scalled2.png
#printf "%s" "$NVD_TEMP"

tempCore=$( nvidia-smi -q | grep 'GPU Current Temp' -A 0 | awk '{ print $5 }')

degree="°C"
temperaturesValues=(45 55 60 65 75 80)
temperaturesColors=("#7DF682" "#f4cb24" "#ff8819" "#ff3205" "#f40202" "#ef02db")
#temperaturesIcons=(     )
temperaturesIcons=(     )

for i in ${!temperaturesValues[*]}
do
    if (( ${tempCore} < ${temperaturesValues[$i]} )); then
        tmpEcho="%{F${temperaturesColors[$i]}}${tempCore}$degree%{F-}"
        iconEcho="%{F${temperaturesColors[$i]}}${temperaturesIcons[$i]}%{F-}"
        echo "$iconEcho $tmpEcho"
        break
    fi  
done
