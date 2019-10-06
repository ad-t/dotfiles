#!/bin/sh

killall lemonbar

COLOR="`$HOME/.config/dotfiles/lemonbar/get_xresource_value.sh color0`" && 
$HOME/.config/dotfiles/lemonbar/feeder.sh | $HOME/build_repos/lemonbar-xft/lemonbar -p -f "Inconsolata for Powerline-13" -B "$COLOR" -u 3
