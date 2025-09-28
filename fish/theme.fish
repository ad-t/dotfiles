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

function segment
  set CONTENT "$argv[1]"
  printf "%s" $CONTENT
end

function path_segment
  set PATH_STRING "$argv[1]"
  set GIT "$argv[2]"
  printf "\ue0b6"
  set_color $THM_BG
  set_color -b $THM_FG
  segment $PATH_STRING
  if [ "$GIT" != "" ]
    set_color $THM_FG
    set_color -b $THM_GRAY
    printf "\ue0b4 "
  end
end

function git_segment 
  set GIT "$argv[1]"
  if [ "$GIT" != "" ]
    set_color $THM_BG
    set_color -b $THM_GRAY
    segment (echo $GIT | string replace '(' ' ' | string replace ')' ' ' | string trim --left --right)
  end
  set_color -r
  printf "\ue0b4"
end

function right_prompt
  set_color $THM_GRAY
  set_color -b $THM_BG
  printf "\ue0b6"
  set_color -r
  segment (date +%T)
  set_color $THM_BG
  set_color -b $THM_GRAY
  printf "\ue0b4"
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
