#!/bin/bash
sed -i "s/.*gtk-theme-name=.*/gtk-theme-name=Fleon/g" ~/.config/gtk-3.0/settings.ini
sed -i "s/.*gtk-icon-theme-name=.*/gtk-icon-theme-name=Bluecurve8/g" ~/.config/gtk-3.0/settings.ini
sed -i "s/.*gtk-theme-name=.*/gtk-theme-name=\"Fleon\"/g" ~/.gtkrc-2.0
sed -i "s/.*gtk-icon-theme-name=.*/gtk-icon-theme-name=\"Bluecurve8\"/g" ~/.gtkrc-2.0

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
