#!/bin/bash

if [ $# -ne 4 ]; then
   echo "Usage: wmctrl_example.sh pos_x pos_y size_x size_y"
   exit 1
fi

pos_x=$1
pos_y=$2
size_x=$3
size_y=$4

win=`xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}'` 
pos=(`xdotool getwindowgeometry $win | grep 'Position' | sed -e 's/.*: \(.*\)\,\(.*\) (.*/\1 \2/'`)
size=(`xdotool getwindowgeometry $win | grep 'Geometry' | sed -e 's/.*: \(.*\)x\(.*\).*/\1 \2/'`)

[ $pos_x -eq -1 ] && pos_x=${pos[0]};
[ $pos_y -eq -1 ] && pos_y=${pos[1]};
[ $size_x -eq -1 ] && size_x=${size[0]};
[ $size_y -eq -1 ] && size_y=${size[1]};

mon_x=1920
mon_y=1080
default_pos_x=$(echo "$mon_x/2" | bc)
default_pos_y=$(echo "$mon_y/2" | bc)
default_size_x=500
default_size_y=400

echo "wmctrl -r :ACTIVE: -e 0,$pos_x,$pos_y,$size_x,$size_y"
wmctrl -r :ACTIVE: -e 0,$pos_x,$pos_y,$size_x,$size_y

xwininfo -root -children
wmctrl -r 0x0340000a -i -t 0
xdotool windowactivate 0x03200007
wmctrl -R 0x03a00007 -i
wmctrl -l | sed -e 's/^\([0-9a-fx]*\).*$/\1/' | xargs
wmctrl -lx |  awk -F' ' '{printf("%s\t%s    \t",$1,$3); for(i=5;i<=NF;i++) printf("%s",$i); printf("\n")  }'
xprop -root _NET_CLIENT_LIST | cut -d' ' -f5- | sed 's/,//g'

	XTIME="_NET_WM_USER_TIME" #a shorter name for xprop query that shoul return timestamps
	export TMPDIR=/dev/shm    #save tmp files to memory to make it faster
	LST=`mktemp`              #tmp file to store our listing 
	wmctrl -lx |  awk -F' ' '{printf("%s\t%s    \t",$1,$3); for(i=5;i<=NF;i++) printf("%s",$i); printf("\n")  }'  > $LST #pretty-print our listing of windows into the tmp file
	#To each line of listing, prepend a timestamp acquired via an xprop call
	#Use awk to find a line whose 3rd column (winclass) matches the window class "mate-terminal.Mate-terminal" and among those that do, find the one whose timestamp is the largest
	while read LINE; do ID=`echo "$LINE"|cut -f 1`; TIME=`xprop -id $ID $XTIME`;  TIME="${TIME/* = /}"; echo -e "$TIME\t$LINE" ; done <$LST ) | awk -v s="mate-terminal.Mate-terminal" '$3 == s {if($1>max){max=$1;line=$0};};END{print line}'
	rm $LST  #delete tmp file
	
printf 0x%x 69206716

printf %i 0x42002bc



