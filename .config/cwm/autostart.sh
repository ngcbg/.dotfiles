############################
# CWM autostart script   #
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
export XDG_CURRENT_DESKTOP=xfce
export WM=cwm
export COLORTERM=truecolor
setxkbmap -layout us,bg -variant ,phonetic -option grp:alt_shift_toggle

# Set personalized GTK elemnts per WM
sed -i "s/.*gtk-theme-name=.*/gtk-theme-name=Fantome/g" ~/.config/gtk-3.0/settings.ini
sed -i "s/.*gtk-icon-theme-name=.*/gtk-icon-theme-name=umicons/g" ~/.config/gtk-3.0/settings.ini

if [ -d /usr/share/fonts ]; then
    for i in /usr/share/fonts/*; do
        xset fp+ $i
    done
    xset fp rehash
fi

if [ -d /home/ngc/.fonts ]; then
    for i in /home/ngc/.fonts/*; do
        xset fp+ $i
    done
    xset fp rehash
fi

run xrandr --output DP-2 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-0 --mode 2560x1440 --pos 2560x0 --rotate right
run picom -b --vsync-use-glfinish --config ~/picom.NGC &
#run /usr/bin/xcompmgr -c -C -f -F -r4.2 -o.40 -D3 &

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
run /usr/bin/sxhkd -c ~/.config/cwm/sxhkd/sxhkdrc &
run /usr/bin/dunst &
run /usr/bin/xfce4-power-manager --daemon &
run /usr/bin/nm-applet &
#run /usr/bin/pamac-tray &
run /usr/bin/volumeicon &
run /usr/bin/numlockx on &
#/usr/bin/tint2 2>&1 & disown
/home/ngc/.config/polybar/launch.sh
/usr/bin/sct 5500 1>/dev/null &
/home/ngc/.bin/cwmnitro.sh

#pkill plank
#run nice /usr/bin/plank
