#!/usr/local/bin/bash

if pgrep "xcompmgr" &>"0"; then
	echo "Turning composite effects OFF"
    	notify-send -t 2000 "Turning composite effects OFF"
    	pkill xcompmgr &
    	pkill compton &
else
	echo "Turning composite effects ON"
    	notify-send -t 2000 "Turning composite effects ON"
    	xcompmgr -c -C -r4.2 -o.55 -f -F -D3 &
fi

exit 0
