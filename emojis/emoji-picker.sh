#!/bin/sh

EMOJI_FILE="$HOME/.config/dotfiles/emojis/emoji-list.txt"
EMOJI_FILE_URL="https://unicode.org/Public/emoji/15.0/emoji-test.txt"

# find if one exists
if [ ! -f "$EMOJI_FILE" ]
then
  # download it if the file doesn't exist
  curl "$EMOJI_FILE_URL" > "$EMOJI_FILE"
  dunstify "Emoji picker" "Downloaded a new emoji list"
fi

EMOJI_SELECTOR_OUTPUT=$(egrep -v "^[# ]" $EMOJI_FILE \
  | egrep -v "^$" \
  | sed -r "s/.*# //" \
  | sed -r "s/E[0-9]+\.[0-9] //g" \
  | rofi -i -dmenu -font 'Fira Code 16' -theme ~/.config/dotfiles/rofi/wal.rasi)

echo "$EMOJI_SELECTOR_OUTPUT" | sed "s/ .*//g" | tr "\n" " " | sed "s/ //g" | xclip -sel CLIPBOARD
