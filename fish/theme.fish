#!/usr/local/bin/fish

function path_string
  set PATH (pwd | sed -r 's/\/home\/[a-z]+/~/')
  echo -n "$PATH"
end

function segment
  set CONTENT "$argv[1]"
  printf " %s " $CONTENT
end

function path
  set_color black
  set_color -b blue
  segment (path_string)
end

function git 
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

function main
  set STATUS "$argv[1]"
  set MODE "$argv[2]"
  set GIT "$argv[3]"

  if [ "$MODE" = "RIGHT" ]
    right_prompt
  else if [ "$MODE" = "GIT" ]
    status_segment $STATUS
    path
    git $GIT
  end
  set_color normal
  echo -n " "
end

set STATUS "$argv[1]"
set MODE "$argv[2]"
set GIT "$argv[3]"

main $STATUS $MODE $GIT
