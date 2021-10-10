#!/bin/sh
# Move a window to the side of a screen.

case "$1" in
	"left") xdotool getactivewindow windowmove 4 y ;;
	"top")  xdotool getactivewindow windowmove x 32 ;;

	"right")
		screen_width=2552
		win_width=$(xdotool getactivewindow  getwindowgeometry --shell | grep WIDTH | cut -d= -f2)
		xdotool getactivewindow windowmove $(( $screen_width - $win_width )) y
		;;
	"bottom")
		screen_height=1425
		win_height=$(xdotool getactivewindow  getwindowgeometry --shell | grep HEIGHT | cut -d= -f2)
		xdotool getactivewindow windowmove x $(( $screen_height - $win_height ))
		;;
	*)
		echo "Unsupported: \"$1\""
		exit 1
esac
