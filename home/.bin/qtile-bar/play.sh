#!/bin/bash
#playingColor="%{F#78a090}"
#pausedColor="%{F#65737E}" # Gray
#stoppedColor="%{F#65737E}" # Gray ligconsolata reg. 16
 #" " 
fr= 
play=$(playerctl metadata --format '{{artist}} - {{title}}')
player=$(playerctl -l | cut -d. -f1)
	if [ "$player" = 'audacious' ]; then
		icon=" "
	  elif [ "$player" = 'firefox' ]; then
		  icon=" "
	else
		icon=" "
	fi

printf "%s" "$icon" "$player"": ""  ""$play"

