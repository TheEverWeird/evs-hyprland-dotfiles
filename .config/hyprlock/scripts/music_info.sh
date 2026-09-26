#!/usr/bin/env bash

# Automatically detect Lollypop or any active player
PLAYER=$(playerctl -l 2>/dev/null | grep -i "lollypop" | head -n 1)
if [ -z "$PLAYER" ]; then
    PLAYER="%any"
fi

case "$1" in
    --source)
        playerctl -p "$PLAYER" metadata --format '{{playerName}}' 2>/dev/null || echo "Offline"
        ;;
    --title)
        playerctl -p "$PLAYER" metadata --format '{{title}}' 2>/dev/null || echo "Not Playing"
        ;;
    --artist)
        playerctl -p "$PLAYER" metadata --format '{{artist}}' 2>/dev/null || echo ""
        ;;
    --status)
        STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)
        if [ "$STATUS" = "Playing" ]; then
            echo "⏸"
        else
            echo "▶"
        fi
        ;;
    --cover)
        ART_URL=$(playerctl -p "$PLAYER" metadata mpris:artUrl 2>/dev/null)
        if [ -n "$ART_URL" ]; then
            CLEAN_PATH=$(echo "$ART_URL" | sed 's@file://@@')
            cp "$CLEAN_PATH" /tmp/lollypop-cover.png 2>/dev/null
        fi
        ;;
esac
