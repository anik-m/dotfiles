#!/bin/bash

# Terminate already running bar instances
killall -q polybar


# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do : ; done
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
