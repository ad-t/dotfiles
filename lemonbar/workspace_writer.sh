#!/bin/sh

while read WORKSPACE_LINE
do
  echo "$WORKSPACE_LINE" > ~/.config/dotfiles/lemonbar/workspaces.txt
done
