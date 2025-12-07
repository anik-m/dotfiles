#!/usr/bin/env bash
set -e

BASE="$HOME/.config/waybar/config.json"
HYPR="$HOME/.config/waybar/frag-hypr.json"
SWAY="$HOME/.config/waybar/frag-sway.json"
STYLE="$HOME/.config/waybar/style.css"

# detect Hyprland
if [ -n "$HYPRLAND_DISPLAY" ] || pgrep -x hyprland >/dev/null 2>&1; then
  waybar -c "$BASE" -s "$STYLE" "$HYPR"
else
  waybar -c "$BASE" -s "$STYLE" "$SWAY"
fi
