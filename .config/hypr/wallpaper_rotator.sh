#!/usr/bin/env bash

WALLPAPER_DIR="/home/ev/Pictures/Wallpapers"
INTERVAL=1800 # 30 minutes in seconds

while true; do
    # Select a random JPG or PNG file
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)

    if [ -n "$WALLPAPER" ]; then
        # Preload the chosen image
        hyprctl hyprpaper preload "$WALLPAPER"
    
        # Apply to DP-1
        hyprctl hyprpaper wallpaper "DP-1,$WALLPAPER"
    
        # Wait for the change to render, then clean up memory
        sleep 2
        hyprctl hyprpaper unload all
    fi

    sleep $INTERVAL
done