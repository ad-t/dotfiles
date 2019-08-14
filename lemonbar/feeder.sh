#!/bin/sh

BAR_RUN_DIR="$HOME/.config/dotfiles/lemonbar"

while true
do
  BAR=$($BAR_RUN_DIR/bar.py "$BAR_RUN_DIR")
  echo "$BAR"
  sleep 0.25
done
