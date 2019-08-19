#!/bin/sh

killall lemonbar

COLOR="`$HOME/.config/dotfiles/lemonbar/get_xresource_value.sh color0`"

$HOME/.config/dotfiles/lemonbar/feeder.sh | lemonbar -p -d -f "Inconsolata for Powerline-13" -B "$COLOR"
