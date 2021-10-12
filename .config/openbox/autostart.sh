############################
# Openbox autostart script #
############################

#!/bin/bash

function run {
 if ! pgrep $1 ;
  then
    $@&
 fi
}

xset b off
xrdb -merge ~/.Xresources &
. ~/.bashrc
export DE=xfce
setxkbmap -layout us,bg -variant ,phonetic -option grp:alt_shift_toggle
# Set personalized GTK elemnts per WM (Multiple WM's on the same machine)
sed -i "s/.*gtk-theme-name=.*/gtk-theme-name=Graphite-dark-nord/g" ~/.config/gtk-3.0/settings.ini
sed -i "s/.*gtk-icon-theme-name=.*/gtk-icon-theme-name=retrosmart-icon-theme/g" ~/.config/gtk-3.0/settings.ini

run xrandr  --output DP-4 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output HDMI-0 --mode 2560x1440 --pos 2560x0 --rotate normal
run /usr/bin/picom -b  --config ~/picom.NGC &
#run /usr/bin/xcompmgr -c -C -f -F -r4.2 -o.40 -D3 &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
run /usr/bin/dunst &
run /usr/bin/xfce4-power-manager --daemon &
run /usr/bin/nm-applet
run /usr/bin/volumeicon
/home/ngc/.config/polybar/launch.sh
/usr/bin/sct 5500 1>/dev/null &
#/usr/bin/tint2 2>&1 & disown
run /usr/bin/nitrogen --restore
#pkill plank
#sleep 1 && run nice /usr/bin/plank
