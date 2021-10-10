#!/bin/bash

if	pgrep -x xcompmgr &>"0"
then
	killall xcompmgr & echo "Xcompmgr off" >/tmp/xcompmgr.log 2>&1 &
	notify-send -t 2000 "Turning Xcompmgr " 
	/usr/bin/picom -b --config /home/ngc/picom.NGC & echo "Picom off" >/tmp/picom.log 2>&1 &
	notify-send -t 2000 "Turning Picom "
	
elif pgrep -x picom &>"0" 
then 
	killall picom && echo "Picom Off" >/tmp/picom.log 2>&1 &
	notify-send -t 2000 "Turning Picom " 			
else	
	notify-send -t 2000 "Turning Xcompmgr "
    /usr/bin/xcompmgr -c -C -f -F -r4.2 -o.40 -D3 & echo "Xcompmgr on" >/tmp/xcompmgr.log 2>&1 &
fi
exit 0
