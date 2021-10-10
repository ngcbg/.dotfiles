#!/bin/bash

#Xaxis=$(xrandr --current | grep '*+' | uniq | awk '{print $1}' |  cut -d 'x' -f1) #2560 
#Yaxis=$(xrandr --current | grep '*+' | uniq | awk '{print $1}' |  cut -d 'x' -f2) #1440 
#WIDTH=$(echo "scale=0;$Xaxis*.50"|bc)
#HEIGHT=$(echo "scale=0;$Yaxis*.96"|bc)
#X=$(echo "scale=0;$Xaxis/1.345-$WIDTH/2"|bc)
#Y=$(echo "scale=0;$Yaxis/1.98-$HEIGHT/2"|bc)
#WIN=`xdotool getactivewindow`
#echo Resolution: $Xaxis x $Yaxis
#echo New dimensions: $WIDTH x $HEIGHT
#echo New position: $X x $Y
## unmaximize
#wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
#xdotool windowmove $WIN $X $Y
#xdotool windowsize $WIN $WIDTH $HEIGHT
#xdotool getactivewindow windowsize 1295 1392 && xdotool getactivewindow windowmove 1260 34
#wmctrl -r :ACTIVE: -b add,maximized_vert && xdotool getactivewindow windowmove 0 34


wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz


1q=$(wmctrl -r :ACTIVE: -e 0,05,34,1270,1393)
2q=$(wmctrl -r :ACTIVE: -e 0,1270,34,1285,1393)
3q=$(wmctrl -r :ACTIVE: -e 0,2565,34,1255,1393)
4q=$(wmctrl -r :ACTIVE: -e 0,3830,34,1275,1393)


ACT=$(xdotool getactivewindow) && WNAME=$(xdotool getactivewindow getwindowname)
if [ "$WNAME" == "Desktop" ]; then exit 3; fi

D=0                 # Decoration heigth
M=0                 # Border width

if [ "$D" -gt "0" ]; then D=$(( $D + $M )); fi

getwindowgeometry() {
    unset X Y W H ID
    eval $(xwininfo -id $1 | 
        sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/X=\1/p" \
               -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/Y=\1/p" \
               -e "s/^ \+Width: \+\([0-9]\+\).*/W=\1/p" \
               -e "s/^ \+Height: \+\([0-9]\+\).*/H=\1/p" \
               -e "s/^.*\+Window id: \+\([0-9a-fx]\+\).*/ID=\1/p" )

        X=$(( $X - $M ))
        Y=$(( $Y - $M - $D ))
}
getwindowgeometry $ACT
