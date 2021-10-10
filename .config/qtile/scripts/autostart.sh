#!/bin/bash

########################
# QTILE startup script #
########################

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

xset b off
xrdb -merge ~/.Xresources &
. ~/.bashrc
. ~/.zshrc
export DE=xfce
export XDG_CURRENT_DESKTOP=xfce
setxkbmap -layout us,bg -variant ,phonetic -option grp:alt_shift_toggle
# Set personalized GTK elemnts per WM
sed -i "s/.*gtk-theme-name=.*/gtk-theme-name=Arc-Botticelli-Dark/g" ~/.config/gtk-3.0/settings.ini
sed -i "s/.*gtk-icon-theme-name=.*/gtk-icon-theme-name=buuf3.34/g" ~/.config/gtk-3.0/settings.ini

run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &
run xrandr  --output DP-4 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output HDMI-0 --mode 2560x1440 --pos 2560x0 --rotate normal
run /usr/bin/picom -b  --config ~/picom.NGC &
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#/usr/lib/xfce4/notifyd/xfce4-notifyd &
run /usr/bin/dunst &
run /usr/bin/xfce4-power-manager --daemon &
run /usr/bin/nm-applet &
#run /usr/bin/pamac-tray &
run /usr/bin/volumeicon &
run /usr/bin/numlockx on &
#~/.config/polybar/launch.sh
/usr/bin/sct 5500 1>/dev/null &
run /home/ngc/.fehbg
run /usr/bin/mocp -S 

