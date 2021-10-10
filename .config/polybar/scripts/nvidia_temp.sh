#!/bin/bash

# fork from Per-core temperatures :
# https://github.com/jaagr/polybar/wiki/User-contributed-modules#per-core-temperatures

#numCompare() {
#   awk -v n1="$1" -v n2="$2" 'BEGIN {printf "%s " (n1<n2?"<":">=") " %s\n", n1, n2}'
#}

# Get information from cores temp thanks to sensors
#rawData=$( sensors | grep -m 1 Core | awk '{print substr($3, 2, length($3)-5)}' )
rawData=$( nvidia-smi -q | grep 'GPU Current Temp' -A 0 | awk '{ print $5 }' | sed 's/C//g' )
tempCore=($rawData)

# Define constants :
degree="°C"
temperaturesValues=(45 55 65 75 85 90)
temperaturesColors=("#C4CFFF" "#f4cb24" "#ff8819" "#ff3205" "#f40202" "#ef02db")
temperaturesIcons=(     )

for iCore in ${!tempCore[*]}
do
    for iTemp in ${!temperaturesValues[*]}
    do
        if [[ ${tempCore[$iCore]} < ${temperaturesValues[$iTemp]} ]]; then
            tmpEcho="%{F${temperaturesColors[$iTemp]}}${tempCore[$iCore]}$degree%{F-}"
            finalEcho="$finalEcho $tmpEcho"
            break
        fi
    done
    total=$(( ${tempCore[$iCore]} + total ));
done

sum=$(( $total/${#tempCore[*]} ))

for iTemp in ${!temperaturesValues[*]}
do
    if (( "$sum" < "${temperaturesValues[$iTemp]}" )); then
        ## This line will color the icon too
        tmpEcho="%{F${temperaturesColors[$iTemp]}}${temperaturesIcons[$iTemp]}%{F-}"
        ## This line will NOT color the icon
        #tmpEcho="${temperaturesIcons[$iTemp]}"
        finalEcho=" $finalEcho $tmpEcho"
        break
    fi
done

echo $finalEcho
