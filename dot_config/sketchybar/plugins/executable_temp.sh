#!/usr/bin/env sh
# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting
LOCATION="Luxembourg,%20Luxembourg" # set to your location
TEMP=`curl -s "https://wttr.in/${LOCATION}?format=3" | gsed 's|  *| |g' | gsed 's|.*: ||'`
echo $TEMP

sketchybar --set $NAME label="${TEMP}" align=center padding_left=-5 \ 

	   --set $NAME click_script="/usr/bin/open /System/Applications/Weather.app"