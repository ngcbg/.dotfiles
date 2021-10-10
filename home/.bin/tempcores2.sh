#!/bin/bash

#numCompare() {
#   awk -v n1="$1" -v n2="$2" 'BEGIN {printf "%s " (n1<n2?"<":">=") " %s\n", n1, n2}'
#}

tempCore=$( sensors | grep Tdie | awk '{ print $2 }' | cut -c2- | cut -c-2 )

degree="°C"
temperaturesValues=(35 45 55 65 75 80)
temperaturesColors=("#93A7FF" "#f4cb24" "#ff8819" "#ff3205" "#f40202" "#ef02db")
temperaturesIcons=(     )

for i in ${!temperaturesValues[*]}
do
    if (( ${tempCore} < ${temperaturesValues[$i]} )); then
        tmpEcho="%{F${temperaturesColors[$i]}}${tempCore}$degree%{F-}"
        iconEcho="%{F${temperaturesColors[$i]}}${temperaturesIcons[$i]}%{F-}"
        echo "$tmpEcho $iconEcho"
        break
    fi  
done
