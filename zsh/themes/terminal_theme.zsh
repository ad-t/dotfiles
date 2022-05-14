#!/bin/zsh

# Table from: https://ss64.com/nt/syntax-ansi.html
#                                   F       B       Color equivalent
# Black BLACK                       \e[30m	\e[40m	0
# Red DARK_RED                      \e[31m	\e[41m	4
# Green DARK_GREEN                  \e[32m	\e[42m	2
# Yellow DARK_YELLOW                \e[33m	\e[43m	6
# Blue DARK_BLUE                    \e[34m	\e[44m	1
# Magenta DARK_MAGENTA              \e[35m	\e[45m	5
# Cyan DARK_CYAN                    \e[36m	\e[46m	3
# Light gray DARK_WHITE             \e[37m	\e[47m	7
# Dark gray BRIGHT_BLACK            \e[90m	\e[100m	8
# Light red BRIGHT_RED              \e[91m	\e[101m	C
# Light green BRIGHT_GREEN          \e[92m	\e[102m	A
# Light yellow BRIGHT_YELLOW        \e[93m	\e[103m	E
# Light blue BRIGHT_BLUE            \e[94m	\e[104m	9
# Light magenta BRIGHT_MAGENTA      \e[95m	\e[105m	D
# Light cyan BRIGHT_CYAN            \e[96m	\e[106m	B
# White WHITE                       \e[97m	\e[107m	F
# Bold	                            \e[1m	 	 
# Underline	                        \e[4m	 	 
# No underline	                    \e[24m	 	 
# Reverse text	                    \e[7m	 	 
# Positive text (not reversed)	    \e[27m	 	 
# Default	                          \e[0m

set_color() {
  COLOR="$1"
  COLOR_CODE=""
  case $COLOR in
    BLACK)
      COLOR_CODE="30"
      ;;
    RED)
      COLOR_CODE="31"
      ;;
    GREEN)
      COLOR_CODE="32"
      ;;
    BLUE)
      COLOR_CODE="34"
      ;;
    MAGENTA)
      COLOR_CODE="35"
      ;;
    CYAN)
      COLOR_CODE="36"
      ;;
    WHITE)
      COLOR_CODE="37"
      ;;
  esac
  echo -n "%{\e[${COLOR_CODE}m%}"
}

set_background() {
  COLOR="$1"
  COLOR_CODE=""
  case $COLOR in
    BLACK)
      COLOR_CODE="40"
      ;;
    RED)
      COLOR_CODE="41"
      ;;
    GREEN)
      COLOR_CODE="42"
      ;;
    BLUE)
      COLOR_CODE="44"
      ;;
    MAGENTA)
      COLOR_CODE="45"
      ;;
    CYAN)
      COLOR_CODE="46"
      ;;
    WHITE)
      COLOR_CODE="47"
      ;;
  esac
  echo -n "%{\e[${COLOR_CODE}m%}"
}

reset_color() {
  echo -n "%{\e[0m%}"
}

reset_background() {
  echo -n "%{\e[0m%}"
}

segment_prompt() {
  CONTENT="$1"
  PRIMARY="$2"
  SECONDARY="$3"

  set_color "$PRIMARY"
  set_background "$SECONDARY"
  
  echo -n " $CONTENT "

  reset_color
  reset_background
}

separator() {
  SEPARATOR_DIRECTION="$1"
  PRIMARY="$2"
  SECONDARY="$3"

  if test "$SEPARATOR_DIRECTION" = 'left'
  then
    SEPARATOR="\ue0b2"
  else
    SEPARATOR="\ue0b0"
  fi

  set_color "$PRIMARY"
  set_background "$SECONDARY"

  echo -n "$SEPARATOR"

  # reset_color
  # reset_background
}

swap_colours_on() {
  echo -n "%S"
}

swap_colours_off() {
  echo -n "%s"
}

show_retval() {
  RETVAL="$1"
  PRIMARY="$2"
  SECONDARY="$3"
  if [ "$RETVAL" -ne 0 ]
  then
    segment_prompt "$RETVAL" "$PRIMARY" "$SECONDARY"
    separator "right" "$SECONDARY" "BLUE"
  fi
}

get_path() {
  PWD_FIXED=$(pwd | sed -r "s/\/home\/[a-z]+/~/g")
  # shorten path to single character
  BASENAME=$(basename "$PWD_FIXED")
  PWD_FIXED=$(echo $PWD_FIXED | sed -r "s/\/.?[A-Za-z0-9_-]+$//" | sed -r "s/([A-Za-z0-9_])[A-Za-z0-9_]+/\1/g")
  if test "$BASENAME" = "~"
  then
    echo "$BASENAME"
  else
    echo "$PWD_FIXED/$BASENAME"
  fi
}

get_git() {
  PRIMARY="$1"
  SECONDARY="$2"
  # test if in git repo
  if git status > /dev/null 2>&1
  then
    # find the branch we're on
    GIT_BRANCH="$(git branch | egrep "^\*" | sed "s/^\* *//")"

    STATUS_OUTPUT=$(git status)
    # find out whether we have untracked files
    if echo "$STATUS_OUTPUT" | egrep "^Untracked" > /dev/null 2>&1
    then
      GIT_UNTRACKED="-"
    fi
    # find out whether we have unstaged changes
    if echo "$STATUS_OUTPUT" | egrep "^Changes not staged for commit" > /dev/null 2>&1
    then
      GIT_UNSTAGED="*"
    fi
    # find out whether we have added changes
    if echo "$STATUS_OUTPUT" | egrep "^Changes to be committed" > /dev/null 2>&1
    then
      GIT_ADDED="+"
    fi
    segment_prompt "\ue0a0 $GIT_BRANCH$GIT_UNTRACKED$GIT_UNSTAGED$GIT_ADDED" "$PRIMARY" "$SECONDARY"
  fi
}

info_prompt() {
  RETVAL="$1"
  show_retval "$RETVAL" "BLACK" "RED"
  segment_prompt "$(get_path)" "BLACK" "BLUE"
  separator "right" "BLUE" "CYAN"
  get_git "BLACK" "CYAN"
  separator "right" "CYAN" "BLACK"
  echo
}

typing_prompt() {
  segment_prompt '$' "BLACK" "BLUE"
  separator "right" "BLUE" "BLACK"
  set_color "WHITE"
  echo -n ' '
}

output_spaces() {
  COMMAND="for i in \$(seq 0 $1)
  do
    printf ' '
  done"
  bash -c "$COMMAND"
}

right_prompt() {
  PRIMARY="$1"
  SECONDARY="$2"
  RIGHT_PROMPT="$(date +%T)"
  RIGHT_PROMPT_LENGTH="$(echo $RIGHT_PROMPT | wc -m)"
  COLUMNS="$(tput cols)"
  SPACES=$(expr $COLUMNS - $RIGHT_PROMPT_LENGTH - 3)
  output_spaces $SPACES
  separator "left" "$SECONDARY" "BLACK"
  segment_prompt "$RIGHT_PROMPT" "BLACK" "$PRIMARY"
  echo -n "\r"
}

main() {
  RETVAL="$1"
  right_prompt "BLACK" "BLUE"
  info_prompt "$RETVAL"
  typing_prompt
}

RETVAL="$1"
main "$RETVAL"
