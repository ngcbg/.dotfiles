#!/bin/sh

#CURR_SCREEN=`xrandr --prop | grep connected | head -n 1 | cut -d " " -f1`

FILE=/tmp/.brightness

if [ -f $FILE ]; then
#touch $FILE && echo "100" > $FILE
    CURR_VAL=$(<$FILE) 
else
    CURR_VAL=0
fi
#echo "VAL:$CURR_VAL"
NEW_VAL=`expr $CURR_VAL + 30`
if [ $NEW_VAL -gt 100 ]; then
    NEW_VAL=10
fi
#echo "NewVal:$NEW_VAL"
#export NEW_VAL=NEW_VAL
echo "$NEW_VAL" > $FILE
#xrandr --output $CURR_SCREEN --brightness 0.$NEW_VAL
xbacklight -set $NEW_VAL
#echo "Display Brightness: $CURR_VAL" 2>&1
if [ $NEW_VAL = "100" ]; then
notify-send "Brightness $NEW_VAL"% -t 1500 -i ~/.config/tint2/icons/DBF2.png 
elif [ $NEW_VAL -lt 100 ]; then
notify-send "Brightness $NEW_VAL"% -t 1500 -i ~/.config/tint2/icons/DBH.png
fi
