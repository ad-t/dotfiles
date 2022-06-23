#!/usr/local/bin/fish

function segment
  set CONTENT "$argv[1]"
  printf " %s " $CONTENT
end

function path_segment
  set PATH_STRING "$argv[1]"
  set_color black
  set_color -b blue
  segment $PATH_STRING
end

function git_segment 
  set GIT "$argv[1]"
  set_color black
  set_color -b purple
  if [ "$GIT" != "" ]
    segment (echo $GIT | string replace '(' ' ' | string replace ')' ' ' | string trim --left --right)
  end
end

function right_prompt
  set_color black
  set_color -b green
  segment (date +%T)
end

function status_segment
  set STATUS "$argv[1]"
  if [ "$STATUS" != "0" ]
    set_color black
    set_color -b red
    segment "$STATUS"
  end
end
