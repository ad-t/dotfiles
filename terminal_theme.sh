#!/bin/sh

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
# NO COLOR: \033[0m


set_color() {
  COLOR="$1"
  COLOR_CODE=""
  case $COLOR in
    BLACK)
      COLOR_CODE="0;30"
      ;;
    RED)
      COLOR_CODE="0;31"
      ;;
    GREEN)
      COLOR_CODE="0;32"
      ;;
    BLUE)
      COLOR_CODE="0;34"
      ;;
  esac
  printf "\033[${COLOR_CODE}m"
}

reset_color() {
  printf "\033[0m"
}

segment_prompt() {
  CONTENT="$1"
  echo -n "[$CONTENT]"
}

prompt_spacer() {
  echo -n " "
}

show_retval() {
  RETVAL="$1"
  if [ "$RETVAL" -ne 0 ]
  then
    segment_prompt "$RETVAL"
    prompt_spacer
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
    prompt_spacer
    segment_prompt "$GIT_BRANCH$GIT_UNTRACKED$GIT_UNSTAGED$GIT_ADDED"
  fi
}

info_prompt() {
  RETVAL="$1"
  set_color "GREEN"
  show_retval "$RETVAL"
  set_color "BLUE"
  segment_prompt "$(get_path)"
  set_color "RED"
  get_git
  reset_color
  echo
}

typing_prompt() {
  echo "$ "
}

output_spaces() {
  COMMAND="for i in \$(seq 0 $1)
  do
    printf '\u2500'
  done"
  bash -c "$COMMAND"
}

right_prompt() {
  RIGHT_PROMPT="$(segment_prompt $(date +%T))"
  RIGHT_PROMPT_LENGTH="$(echo $RIGHT_PROMPT | wc -m)"
  COLUMNS=$(tput cols)
  SPACES=$(expr $COLUMNS - $RIGHT_PROMPT_LENGTH)
  set_color "RED"
  output_spaces $SPACES
  printf "$RIGHT_PROMPT"
  echo -n "\r"
}

main() {
  RETVAL="$1"
  right_prompt
  info_prompt "$RETVAL"
  typing_prompt
}

RETVAL="$1"
main "$RETVAL"
