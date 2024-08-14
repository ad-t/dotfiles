#!/usr/local/bin/fish

set THM_BG "#2e3440"
set THM_FG "#d8dee9"
set THM_CYAN "#88c8d0"
set THM_BLACK "#2e3440"
set THM_GRAY "#4c556a"
set THM_MAGENTA "#b48ead"
set THM_PINK "#b38ead"
set THM_RED "#bf616a"
set THM_GREEN "#a3be8c"
set THM_YELLOW "#ebcb8b"
set THM_BLUE "#5e81ac"
set THM_ORANGE "#d80770"
set THM_BLACK4 "#3b4252"

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
