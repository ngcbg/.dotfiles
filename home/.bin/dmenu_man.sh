#!/bin/fish 
#set -x MANPAGER sh -c 'col -bx | bat -l man -p'
man -k -S 1 . | dmenu -l 30 | awk '{print $1}' | xargs -r urxvtc -e man -P most
