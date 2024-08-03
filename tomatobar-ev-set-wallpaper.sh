#!/bin/bash
# logPath="/Users/evanjohnson/Library/Containers/com.github.ivoronin.TomatoBar/Data/Library/Caches/TomatoBar.log"
logPath="/Users/evanjohnson/Library/Containers/com.github.evannjohnson.TomatoBar-ev/Data/Library/Caches/TomatoBar.log"
wallpaper_script="$(dirname $0)/wallpaper-set-solidcolor.sh"
state="$(tail -n 1 $logPath | /usr/local/bin/jq -r '.toState')"

if [ "$state" == "work" ]; then
    wallpaper_color="Dusty Rose"
else
    wallpaper_color="Black"
fi

# cat /Users/evanjohnson/Library/Containers/com.github.ivoronin.TomatoBar/Data/Library/Caches/TomatoBar.log
"$wallpaper_script" "$wallpaper_color"
