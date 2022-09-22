#!/bin/bash

kbdlayout=$(xset -q|grep LED| awk '{ print $10 }' | cut -c5)
if [ $kbdlayout = "1" ]
then echo ~/.config/tint2/icons/bg.png
#    notify-send "BG Phonetic Layout"
elif [ $kbdlayout = "0" ] 
then echo ~/.config/tint2/icons/US.png
#    notify-send "US Layout"
fi

