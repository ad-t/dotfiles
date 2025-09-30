#!/usr/local/bin/fish

set THM_BG "#32302f"
set THM_FG "#d4be98"
set THM_CYAN "#89b482"
set THM_BLACK "#665c54"
set THM_GRAY "#928374"
set THM_MAGENTA "#d3869b"
set THM_RED "#ea6962"
set THM_GREEN "#a9b665"
set THM_YELLOW "#d8a657"
set THM_BLUE "#7daea3"
set THM_ORANGE "#e78a4e"

set STATUS_FG $THM_BG
set STATUS_BG $THM_RED
set PATH_FG $THM_BG
set PATH_BG $THM_FG
set GIT_FG $THM_BG
set GIT_BG $THM_GRAY
set RIGHT_FG $THM_BG
set RIGHT_BG $THM_GRAY

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
  if [ "$GIT" != "" ]
    set_color $PATH_BG
    set_color -b $GIT_BG
    printf "\ue0b4 "
  end
end

function git_segment 
  set GIT "$argv[1]"
  if [ "$GIT" != "" ]
    set_color $GIT_FG
    set_color -b $GIT_BG
    segment (echo $GIT | string replace '(' ' ' | string replace ')' ' ' | string trim --left --right)
  end
  set_color -r
  printf "\ue0b4"
end

function right_prompt
  set_color $RIGHT_BG
  set_color -b $RIGHT_FG
  printf "\ue0b6"
  set_color -r
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
    set_color $STATUS_BG
    set_color -b $PATH_BG
    printf "\ue0b4"
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
