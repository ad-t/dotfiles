# vim:ft=zsh ts=2 sw=2 sts=2

CURRENT_BG='NONE'

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  SEGMENT_SEPARATOR=$'\ue0b0'
}

build_segment() {
  CONTENT="$1"
  echo -n "[$CONTENT]"
}

build_retval() {
  RETVAL="$?"
  if test "$RETVAL" -ne 0
  then
    color_prompt "red"
    build_segment "$RETVAL"
  fi
}

build_path() {
  PWD_FIXED=$(pwd | sed -r "s/\/home\/[a-z]+/~/g")
  # shorten path to single character
  BASENAME=$(basename "$PWD_FIXED")
  PWD_FIXED=$(echo $PWD_FIXED | sed -r "s/\/.?[A-Za-z0-9_-]+$//" | sed -r "s/([A-Za-z0-9_])[A-Za-z0-9_]+/\1/g")
  if test "$BASENAME" = "~"
  then
    build_segment "$BASENAME"
  else
    build_segment "$PWD_FIXED/$BASENAME"
  fi
}

build_git() {
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
    build_segment "$GIT_BRANCH$GIT_UNTRACKED$GIT_UNSTAGED$GIT_ADDED"
  fi
}

build_left_prompt() {
  build_retval
  color_prompt "yellow"
  build_path
  color_prompt "red"
  echo -n " "
  build_git
  color_prompt "white"
}

color_prompt() {
  echo -n "%{%F{$1}%}"
}

build_right_prompt() {
  color_prompt "cyan"
  build_segment "$(date +%T)"
  color_prompt "white"
}

output_spaces() {
  for i in $(seq 0 $1)
  do
    echo -n " "
  done
}

build_prompt() {
  LEFT="$(build_left_prompt)"
  LEFT_CHARACTERS=$(echo $LEFT | sed -r 's/%\{%[A-Z]\{[a-z]+\}%\}//g' | wc -m)
  RIGHT="$(build_right_prompt)"
  RIGHT_CHARACTERS=$(echo $RIGHT | sed -r 's/%\{%[A-Z]\{[a-z]+\}%\}//g' | wc -m)
  COLUMNS=$(tput cols)
  SPACES=$(expr $COLUMNS - $RIGHT_CHARACTERS - $LEFT_CHARACTERS + 1)
  echo -n "$LEFT"
  output_spaces "$SPACES"
  echo -n "$RIGHT"
}

build_typing_prompt() {
  echo "$ "
}

PROMPT='%{%f%b%k%}$(build_prompt)
$(build_typing_prompt)'
