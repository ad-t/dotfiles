#!/usr/local/bin/fish

function path
  set PATH (pwd | sed -r 's/\/home\/[a-z]+/~/')
  echo -n "$PATH"
end

# function set_color
#   set COLOR "$1"
#   set CODE ""
#   switch $COLOR
#     case BLACK
#       set CODE "\e[0;30m"
#     case RED
#       set CODE "\e[0;31m"
#     case GREEN
#       set CODE "\e[0;32m"
#     case YELLOW
#       set CODE "\e[0;33m"
#     case BLUE
#       set CODE "\e[0;34m"
#     case PURPLE
#       set CODE "\e[0;35m"
#     case CYAN
#       set CODE "\e[0;36m"
#     case WHITE
#       set CODE "\e[0;37m"
#   end
#   echo -n "$CODE"
# end
# 
# function set_bold_color
#   set COLOR "$1"
#   set CODE ""
#   switch $COLOR
#     case BLACK
#       set CODE "\e[1;30m"
#     case RED
#       set CODE "\e[1;31m"
#     case GREEN
#       set CODE "\e[1;32m"
#     case YELLOW
#       set CODE "\e[1;33m"
#     case BLUE
#       set CODE "\e[1;34m"
#     case PURPLE
#       set CODE "\e[1;35m"
#     case CYAN
#       set CODE "\e[1;36m"
#     case WHITE
#       set CODE "\e[1;37m"
#   end
#   echo -n "$CODE"
# end
# 
# function set_background
#   set COLOR "$1"
#   set CODE ""
#   switch $COLOR
#     case BLACK
#       set CODE "\e[40m"
#     case RED
#       set CODE "\e[41m"
#     case GREEN
#       set CODE "\e[42m"
#     case YELLOW
#       set CODE "\e[43m"
#     case BLUE
#       set CODE "\e[44m"
#     case PURPLE
#       set CODE "\e[45m"
#     case CYAN
#       set CODE "\e[46m"
#     case WHITE
#       set CODE "\e[47m"
#   end
#   echo -n "$CODE"
# end

# function reset_color
#   printf "%s" "\e[0m"
# end

function segment
  set CONTENT "$argv[1]"
  printf " %s " $CONTENT
end

set STATUS "$argv[1]"
set MODE "$argv[2]"
set GIT "$argv[3]"
# echo $STATUS 
# echo $MODE 
# echo $GIT
if [ "$MODE" = "RIGHT" ]
  set_color black
  set_color -b green
  segment (date +%T)
else if [ "$MODE" = "GIT" ]
  if [ "$STATUS" != "0" ]
    set_color black
    set_color -b red
    segment "$STATUS"
  end
  set_color black
  set_color -b blue
  segment (path)
  set_color normal
  set_color black
  set_color -b purple
  if [ "$GIT" != "" ]
    segment (echo $GIT | string replace '(' ' ' | string replace ')' ' ' | string trim --left --right)
  end
end
set_color normal
echo -n " "
