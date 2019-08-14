#!/bin/sh

killall lemonbar

$HOME/.config/dotfiles/lemonbar/feeder.sh | lemonbar -p -f "Inconsolata for Powerline-13"
