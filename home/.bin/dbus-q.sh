#!/bin/sh

while true ; do
    for m in `dbus | egrep -i 'org.mpris.MediaPlayer2|plasma-browser-integration'` ; do
        if [[ `dbus $m /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus` == 'Playing' ]]; then
            echo $m > ~/.config/activePlayer/currentPlaying.txt
        fi
    done
    sleep 1
done