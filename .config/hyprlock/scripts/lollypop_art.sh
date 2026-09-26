#!/usr/bin/env bash
art_url=$(playerctl -p lollypop metadata mpris:artUrl 2>/dev/null)

if [ -n "$art_url" ]; then
    # Strip file:// and decode URL characters
    art_path=$(echo "$art_url" | sed 's@file://@@' | python3 -c "import urllib.parse, sys; print(urllib.parse.unquote(sys.stdin.read().strip()))")
    if [ -f "$art_path" ]; then
        cp "$art_path" /tmp/lollypop-cover.png
        exit 0
    fi
fi

# Fallback default image if no art is active
cp "/home/ev/Pictures/Wallpapers/hypr2.png" /tmp/lollypop-cover.png