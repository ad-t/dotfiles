#!/usr/local/bin/fish

set THM_BG "#181616"
set THM_BLACK "#0D0C0C"
set THM_BLACK2 "#12120F"
set THM_BRIGHTBLACK "#A6A69C"
set THM_RED "#C4746E"
set THM_GREEN "#8A9A7B"
set THM_YELLOW "#C4B28A"
set THM_BLUE "#8BA4B0"
set THM_MAGENTA "#A292A3"
set THM_CYAN "#8EA4A2"
set THM_GRAY "#C8C093"
set THM_FG "#C5C9C5"

set STATUS_FG $THM_BG
set STATUS_BG $THM_RED
set PATH_FG $THM_BG
set PATH_BG $THM_YELLOW
set GIT_FG $THM_BRIGHTBLACK
set GIT_BG $THM_BLACK
set RIGHT_FG $THM_BG
set RIGHT_BG $THM_YELLOW

function segment
  set CONTENT "$argv[1]"
  printf "%s" $CONTENT
end

function path_segment
  set PATH_STRING "$argv[1]"
  set GIT "$argv[2]"
  set_color $PATH_FG
  set_color -b $PATH_BG
  printf " "
  segment $PATH_STRING
  printf " "
end

function git_segment 
  set GIT "$argv[1]"
  if [ "$GIT" != "" ]
    set_color $GIT_FG
    set_color -b $GIT_BG
    printf " "
    segment (echo $GIT | string replace '(' ' ' | string replace ')' ' ' | string trim --left --right)
    printf " "
  end
end

function right_prompt
  set_color $RIGHT_BG
  set_color -b $RIGHT_FG
  set_color -r
  printf " "
  segment (date +%T)
  printf " "
end

function status_segment
  set STATUS "$argv[1]"
  if [ "$STATUS" != "0" ]
    set_color $STATUS_FG
    set_color -b $STATUS_BG
    printf " "
    segment "$STATUS"
    printf " "
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
