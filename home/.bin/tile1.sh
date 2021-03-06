#!/bin/bash

TMPFILE=$(mktemp --tmpdir winlist.XXXX)

#arrKB=(super+alt+7 super+alt+9 super+alt+3 super+alt+1 super+alt+5)

# get window list, save to tempfile
wmctrl -lx > "$TMPFILE"

declare -a arrWIN_ID

CURRDTOP=$(xprop -root _NET_CURRENT_DESKTOP | tail -c -2) # desktop number

# read window list, get window ID's on current desktop
i=0
while read -r line;do
    if grep -Eq -v "(Conky|Tint2)" "$TMPFILE";then
        if [[ $(echo "$line" | awk '{print $2}') == $CURRDTOP ]];then
            arrWIN_ID[$i]=$(echo "$line" | awk '{print $1}')
            ((i+=1))
        fi
    fi
done < "$TMPFILE"
