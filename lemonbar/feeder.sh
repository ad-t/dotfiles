#!/bin/sh

while true
do
  BAR=$($HOME/.config/dotfiles/lemonbar/bar.py)
  echo "$BAR"
  sleep 0.5
done
