#!/bin/bash

if	pgrep -x "xcompmgr" &>"0"
then
	killall xcompmgr & echo "Xcompmgr OFF" >/tmp/xcompmgr.log 2>&1 &
	notify-send -t 2000 "Turning composite effects OFF" 
	
elif pgrep -x "picom" &>"0"
then 
	killall picom && echo "Picom OFF" >/tmp/picom.log 2>&1 &
	notify-send -t 2000 "Turning Xcompmgr OFF" 			
fi	
	notify-send -t 2000 "Turning Xcompmgr ON"
	/usr/bin/xcompmgr -c -C -f -F -r4.2 -o.40 -D3 & echo "Xcompmgr ON" >/tmp/xcompmgr.log 2>&1 &

exit 0
