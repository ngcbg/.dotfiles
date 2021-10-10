#Turning Xcompmgr composite effects ON
if pgrep xcompmgr &>/dev/null; then
   pkill xcompmgr &
fi
if pgrep compton &>/dev/null; then
   pkill compton &
fi
notify-send -t 2500 "Composite effects OFF"

