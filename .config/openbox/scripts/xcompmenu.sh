#Turning Xcompmgr composite effects ON
if pgrep xcompmgr &>/dev/null; then
   pkill xcompmgr &
fi
if pgrep picom &>/dev/null; then
   pkill picom &
fi
notify-send -t 2500 "Turning XCOMPMGR effects ON"
/usr/bin/xcompmgr -c -C -f -F -r4.2 -o.40 -D3 >>/tmp/xcompmgr.log 2>&1 &
