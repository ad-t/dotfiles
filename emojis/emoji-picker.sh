#!/bin/sh

EMOJI_FILE="$HOME/.config/dotfiles/emojis/emoji-list.txt"
EMOJI_FILE_URL="https://unicode.org/Public/emoji/13.0/emoji-sequences.txt"

# find if one exists
if [ ! -f "$EMOJI_FILE" ]
then
  # download it if the file doesn't exist
  curl "$EMOJI_FILE_URL" > "$EMOJI_FILE"
  dunstify "Emoji picker" "Downloaded a new emoji list"
fi

EMOJI_SELECTOR_OUTPUT=$(egrep -v "^[# ]" $EMOJI_FILE \
  | egrep -v "^$" \
  | cut -d ';' -f 3 \
  | sed -r "s/^ *//g" \
  | sed -r "s/ +/ /g" \
  | sed -r "s/#/-/g" \
  | sed -r "s/E[0-9]+\.[0-9] +\[[0-9]+\] //g" \
  | sed -r "s/[()]//g" \
  | sed -r "s/(.*) - (.*)/\2 - \1/g" \
  | sed -r "s/\..* -/ -/g" \
  | rofi -dmenu)

echo "$EMOJI_SELECTOR_OUTPUT" | sed "s/ -.*//g" | xclip -sel CLIPBOARD
