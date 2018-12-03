#!/bin/bash
# needs https://github.com/wmutils/core for wattr
 
eval $(xdotool getmouselocation --shell)
IFS=" " read -a window <<< $(wattr whxy $(bspc query -N -n focused))
 
north=$(( Y - window[3]))
west=$(( X - window[2]))
width=${window[0]}
height=${window[1]}
 
if [ "$1" = "right" ]; then
    ratio=$(echo "$west / $width" | bc -l)
    bspc node -p east -o $ratio
elif [ "$1" = "left" ]; then
    ratio=$(echo "$west / $width" | bc -l)
    bspc node -p west -o $ratio
elif [ "$1" = "up" ]; then
    ratio=$(echo "$north / $height" | bc -l)
    bspc node -p north -o $ratio
elif [ "$1" = "down" ]; then
    ratio=$(echo "$north / $height" | bc -l)
    bspc node -p south -o $ratio
fi
 
terminal
 
bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel
