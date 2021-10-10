#!/bin/bash

#numCompare() {
#   awk -v n1="$1" -v n2="$2" 'BEGIN {printf "%s " (n1<n2?"<":">=") " %s\n", n1, n2}'
#}

#rawData=$( sensors | grep -m 1 Core | awk '{print substr($3, 2, length($3)-5)}' )
rawData=$( sensors | grep Tdie | awk '{ print $2 }' | cut -c2- | cut -c-2 )
tempCore=($rawData)

degree="°C"
temperaturesValues=(35 45 55 65 75 80)
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
        
        tmpEcho="%{F${temperaturesColors[$iTemp]}}${temperaturesIcons[$iTemp]}%{F-}"
        finalEcho=" $finalEcho $tmpEcho"
        break
    fi
done

echo $finalEcho
