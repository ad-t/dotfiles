#!/bin/sh

# wm agnostic commands to run at startup

# set the background image
feh --bg-fill $HOME/backgrounds/background

# set the default cursor
xsetroot -cursor_name left_ptr

# set the Xresources content
xrdb -merge /home/adam/.Xresources

# start the polybar instances
$HOME/.config/polybar/launch.sh

# fix the F keys
xmodmap -e "keycode 232 = F1" &&
xmodmap -e "keycode 233 = F2" &&
xmodmap -e "keycode 128 = F3" &&
xmodmap -e "keycode 212 = F4" &&
xmodmap -e "keycode 237 = F5" &&
xmodmap -e "keycode 238 = F6" &&
xmodmap -e "keycode 173 = F7" &&
xmodmap -e "keycode 172 = F8" &&
xmodmap -e "keycode 171 = F9" &&
xmodmap -e "keycode 121 = F10" &&
xmodmap -e "keycode 122 = F11" &&
xmodmap -e "keycode 123 = F12"

# set the xrandr screen layout
$HOME/.screenlayout/current
