#!/bin/sh

killall lemonbar

NETMON_PATH="$HOME/.config/dotfiles/utils"

pkill -f "python3 $NETMON_PATH/network-monitor.py"

$NETMON_PATH/network-monitor.py &

ACCENT_COLOR="`$HOME/.config/dotfiles/lemonbar/get_xresource_value.sh color7`" && 
COLOR="`$HOME/.config/dotfiles/lemonbar/get_xresource_value.sh color0`" && 
$HOME/.config/dotfiles/lemonbar/feeder.sh | $HOME/build_repos/lemonbar-xft/lemonbar -p -f "FiraCode-10" -B "$COLOR" -u 3 -U "$ACCENT_COLOR"
