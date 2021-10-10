#!/bin/bash

if pgrep "xcompmgr" &>"0"; then
	#echo "Turning composite effects OFF"
    	#notify-send -t 2000 "Turning xcompmgr OFF"
    	pkill xcompmgr &
fi     	
if pgrep "picom" &>"0"; then
		#notify-send -t 2000 "Turning picom OFF"
    	pkill picom &    	
fi   	
#else
	#echo "Turning composite effects ON"
    	notify-send -t 2000 "Turning xcompmgr effects ON"
    	/usr/bin/xcompmgr -c -C -f -F -r4.2 -o.40 -D3 >>/tmp/xcompmgr.log 2>&1 &


exit 0
