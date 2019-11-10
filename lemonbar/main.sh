#!/bin/sh

killall lemonbar

BLUE_COLOR="`$HOME/.config/dotfiles/lemonbar/get_xresource_value.sh color5`" && 
COLOR="`$HOME/.config/dotfiles/lemonbar/get_xresource_value.sh color0`" && 
$HOME/.config/dotfiles/lemonbar/feeder.sh | $HOME/build_repos/lemonbar-xft/lemonbar -p -f "Iosevka Term SS02-12" -B "$COLOR" -u 3 -U "$BLUE_COLOR"
