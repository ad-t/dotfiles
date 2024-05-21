#!/usr/local/bin/fish

set THM_BG "#1E1E2E"
set THM_FG "#CDD6F4"
set THM_CYAN "#89DCEB"
set THM_BLACK "#181825"
set THM_GRAY "#313244"
set THM_MAGENTA "#CBA6F7"
set THM_PINK "#F5C2E7"
set THM_RED "#F38BA8"
set THM_GREEN "#A6E3A1"
set THM_YELLOW "#F9E2AF"
set THM_BLUE "#89B4FA"
set THM_ORANGE "#FAB387"
set THM_BLACK4 "#585B70"

function segment
  set CONTENT "$argv[1]"
  printf " %s " $CONTENT
end

function path_segment
  set PATH_STRING "$argv[1]"
  set_color $THM_BG
  set_color -b $THM_BLUE
  segment $PATH_STRING
end

function git_segment 
  set GIT "$argv[1]"
  if [ "$GIT" != "" ]
    set_color $THM_FG
    set_color -b $THM_GRAY
    segment (echo $GIT | string replace '(' ' ' | string replace ')' ' ' | string trim --left --right)
  end
end

function right_prompt
  set_color $THM_BG
  set_color -b $THM_BLUE
  segment (date +%T)
end

function status_segment
  set STATUS "$argv[1]"
  if [ "$STATUS" != "0" ]
    set_color $THM_BG
    set_color -b $THM_RED
    segment "$STATUS"
  end
end

function separator
  set BEFORE "$argv[1]"
  set AFTER "$argv[2]"

  set_color "$BEFORE"
  set_color -b "$AFTER"
  printf "\ue0bc"
end

# powerline symbols: https://github.com/ryanoasis/powerline-extra-symbols
