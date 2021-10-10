#!/bin/sh

#Load X options if any
xrdb -merge ~/.Xresources &

# Environment
#. ~/.profile
. ~/.bashrc

#Application and eyecandy integration
#export DE=gnome

#Enable changing keyboard layouts
setxkbmap -layout us,bg -variant ,phonetic -option grp:alt_shift_toggle

# Composite manager
picom -b --config ~/.config/picom.conf &

# start ArcoLinux Welcome  App
#dex $HOME/.config/autostart/arcolinux-welcome-app.desktop

# Polybar & Log
#sleep 1 && HOME/.config/polybar/launch.sh &
echo "---" | tee -a /tmp/polybar1.log
sleep 1 && polybar -c ~/.config/polybar/config bottombar >>/tmp/polybar1.log 2>&1 & disown

# Set background image
#nitrogen --restore
variety &

# Taskbar
tint2 & 

#(am-conky-session --autostart) &

#bluetooth#
#(blueberry-tray) &

# install xcape - press super to get menu
xcape -e 'Super_L=Super_L|space'

#on laptops without seperate numeric keyboard put hashtag in front
numlockx &

## GNOME PolicyKit authentication
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

## Volume control for systray
(volumeicon) &

## Turn off/on System Beep
xset b off

## Enable power management
xfce4-power-manager &

##Clipboard Manager
(xfce4-clipman) &

# Notifications for OpenBox
dunst &

## XFCE4 Settings
xfsettingsd &

(nm-applet) &

#(plank) &

#discord &

#insync start &

#dropbox &

# Display temperature color changer
sct 5500 1>/dev/null &

# Tiling manager
#~/.local/bin/zentile_linux_amd64
