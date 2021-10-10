#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

desktop=$(echo $DESKTOP_SESSION)
count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)

case $desktop in

    i3)
    if type "xrandr" > /dev/null; then
#	  In case of multiple monitors, polybar will be started on each of them.
#	  The second option adds "tail -n1", which selects the first output and therefore - polybar is started only on the first monitor
#     for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | tail -n1); do
        MONITOR=$m nice polybar -r mainbar-i3 -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
      done
    else
    nice polybar -r mainbar-i3 -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
    fi

    ;;

    openbox)
    if type "xrandr" > /dev/null; then
#	  In case of multiple monitors, polybar will be started on each of them.
#	  The second option adds "tail -n1", which selects the first output and therefore - polybar is started only on the first monitor
#     for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | tail -n1); do
        sleep 1 && MONITOR=$m nice polybar -r mainbar-openbox -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
      done
    else
    sleep 1 && nice polybar -r mainbar-openbox -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
    fi
    
    ;;

    xfce)
    if type "xrandr" > /dev/null; then
#	  In case of multiple monitors, polybar will be started on each of them.
#	  The second option adds "tail -n1", which selects the first output and therefore - polybar is started only on the first monitor
#     for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | tail -n1); do
        MONITOR=$m nice polybar -r mainbar-openbox -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
      done
    else
    nice polybar -r mainbar-openbox -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
    fi
    
    ;;

    cwm)
    if type "xrandr" > /dev/null; then
#	  In case of multiple monitors, polybar will be started on each of them.
#	  The second option adds "tail -n1", which selects the first output and therefore - polybar is started only on the first monitor
#     for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | tail -n1); do
        sleep 1 && MONITOR=$m nice polybar -r mainbar-cwm -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
      done
    else
    sleep 1 && nice polybar -r mainbar-cwm -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
    fi

	;;
	
    fvwm3)
    if type "xrandr" > /dev/null; then
#	  In case of multiple monitors, polybar will be started on each of them.
#	  The second option adds "tail -n1", which selects the first output and therefore - polybar is started only on the first monitor
#     for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | tail -n1); do
        MONITOR=$m nice polybar -r mainbar-fvwm3 -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
      done
    else
    nice polybar -r mainbar-fvwm3 -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
    fi
    
    ;;
    
    qtile)
      if type "xrandr" > /dev/null; then
#	  In case of multiple monitors, polybar will be started on each of them.
#	  The second option adds "tail -n1", which selects the first output and therefore - polybar is started only on the first monitor
#     for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | tail -n1); do
        MONITOR=$m nice polybar -r mainbar-qtile -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
      done
    else
    nice polybar -r mainbar-qtile -c ~/.config/polybar/new-polybar >>/tmp/polybar1.log 2>&1 & disown
    fi
    
    ;;
    # second polybar at bottom
    # if [ $count = 1 ]; then
    #   m=$(xrandr --query | grep " connected" | cut -d" " -f1)
    #   MONITOR=$m polybar --reload mainbar-xmonad-extra -c ~/.config/polybar/config &
    # else
    #   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #     MONITOR=$m polybar --reload mainbar-xmonad-extra -c ~/.config/polybar/config &
    #   done
    # fi

esac
