#!/bin/sh

segment_prompt() {
  CONTENT="$1"
  echo -n "[$CONTENT]"
}

prompt_spacer() {
  echo -n " "
}

show_retval() {
  RETVAL="$1"
  if test "$RETVAL" -ne 0
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

info_prompt() {
  RETVAL="$1"
  show_retval "$RETVAL"
  segment_prompt "$(date +%T)"
  prompt_spacer
  segment_prompt "$(get_path)"
  echo
}

typing_prompt() {
  echo "$ "
}

main() {
  RETVAL="$1"
  info_prompt "$RETVAL"
  typing_prompt
}

RETVAL="$1"
main "$RETVAL"
