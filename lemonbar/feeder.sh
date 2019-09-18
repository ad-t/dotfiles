#!/bin/sh

BAR_RUN_DIR="$HOME/.config/dotfiles/lemonbar"

# get amount of displays
AMT_DISPLAYS=$(xrandr | egrep " connected" | sed "s/ connected.*//g" | wc -l)
END_MONITOR=$(expr $AMT_DISPLAYS - 1)
BAR_STRING=""
while true
do
  BAR=$($BAR_RUN_DIR/bar.py "$BAR_RUN_DIR")
  for MONITOR in `seq 0 $END_MONITOR`
  do
    BAR_STRING="$BAR_STRING %{S$MONITOR}$BAR"
  done
  echo "$BAR_STRING"
  BAR_STRING=""
  sleep 0.25
done
