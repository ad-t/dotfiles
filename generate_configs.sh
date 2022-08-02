#!/bin/sh -x 

DUNSTRC="$HOME/.config/dotfiles/dunst/dunstrc"
DUNSTRC_TEMPLATE="$HOME/.config/dotfiles/dunst/dunstrcTemplate"
XRESOURCE_COMMAND="$HOME/.config/dotfiles/lemonbar/get_xresource_value.sh"

ROFI_WAL_RASI="$HOME/.config/dotfiles/rofi/wal.rasi"
ROFI_WAL_RASI_TEMPLATE="$HOME/.config/dotfiles/rofi/wal.template.rasi"

ALACRITTY_TEMPLATE="$HOME/.config/dotfiles/alacritty/template.alacritty.yml"
ALACRITTY="$HOME/.config/dotfiles/alacritty/alacritty.yml"

KITTY_TEMPLATE="$HOME/.config/dotfiles/kitty/kitty.conf.template"
KITTY="$HOME/.config/dotfiles/kitty/kitty.conf"

BLACK=`$XRESOURCE_COMMAND color0`
DARK_RED=`$XRESOURCE_COMMAND color1`
DARK_GREEN=`$XRESOURCE_COMMAND color2`
DARK_YELLOW=`$XRESOURCE_COMMAND color3`
DARK_BLUE=`$XRESOURCE_COMMAND color4`
DARK_MAGENTA=`$XRESOURCE_COMMAND color5`
DARK_CYAN=`$XRESOURCE_COMMAND color6`
BRIGHT_BLACK=`$XRESOURCE_COMMAND color7`
GRAY=`$XRESOURCE_COMMAND color8`
RED=`$XRESOURCE_COMMAND color9`
GREEN=`$XRESOURCE_COMMAND color10`
YELLOW=`$XRESOURCE_COMMAND color11`
BLUE=`$XRESOURCE_COMMAND color12`
MAGENTA=`$XRESOURCE_COMMAND color13`
CYAN=`$XRESOURCE_COMMAND color14`
LIGHT_GRAY=`$XRESOURCE_COMMAND color15`

# define colors
BACKGROUND_COLOR=`$XRESOURCE_COMMAND color0`
LOW_URGENCY_TEXT_COLOR=`$XRESOURCE_COMMAND color7`
LOW_URGENCY_TEXT_COLOR=`$XRESOURCE_COMMAND color7`

# generate dunstrc file
NEW_DUNST_FILE=`cat $DUNSTRC_TEMPLATE |\
  sed -r "s/FRAME_COLOR_ALL/\"$GRAY\"/g"\ |
  sed -r "s/BACKGROUND/\"$BLACK\"/g"\ |
  sed -r "s/LOW_URGENCY_FOREGROUND/\"$DARK_GREEN\"/g"\ |
  sed -r "s/NORMAL_URGENCY_FOREGROUND/\"$LIGHT_GRAY\"/g"\ |
  sed -r "s/CRITICAL_URGENCY_FOREGROUND/\"$DARK_RED\"/g"\
  `

echo "$NEW_DUNST_FILE" > $DUNSTRC

convertColorCodeToRGBA() {
  RGB=$(echo $1 | sed "s/^#//g")
  R=$(echo $RGB | cut -c1,2)
  G=$(echo $RGB | cut -c3,4)
  B=$(echo $RGB | cut -c5,6)
  printf "%d, %d, %d" "0x$R" "0x$G" "0x$B"
}

RGBA_BLACK=$(convertColorCodeToRGBA $BLACK)
RGBA_DARK_RED=$(convertColorCodeToRGBA $DARK_RED)
RGBA_DARK_GREEN=$(convertColorCodeToRGBA $DARK_GREEN)
RGBA_DARK_YELLOW=$(convertColorCodeToRGBA $DARK_YELLOW)
RGBA_DARK_BLUE=$(convertColorCodeToRGBA $DARK_BLUE)
RGBA_DARK_MAGENTA=$(convertColorCodeToRGBA $DARK_MAGENTA)
RGBA_DARK_CYAN=$(convertColorCodeToRGBA $DARK_CYAN)
RGBA_BRIGHT_BLACK=$(convertColorCodeToRGBA $BRIGHT_BLACK)
RGBA_GRAY=$(convertColorCodeToRGBA $GRAY)
RGBA_RED=$(convertColorCodeToRGBA $RED)
RGBA_GREEN=$(convertColorCodeToRGBA $GREEN)
RGBA_YELLOW=$(convertColorCodeToRGBA $YELLOW)
RGBA_BLUE=$(convertColorCodeToRGBA $BLUE)
RGBA_MAGENTA=$(convertColorCodeToRGBA $MAGENTA)
RGBA_CYAN=$(convertColorCodeToRGBA $CYAN)
RGBA_LIGHT_GRAY=$(convertColorCodeToRGBA $LIGHT_GRAY)

# generate dunstrc file
NEW_ROFI_FILE=`cat $ROFI_WAL_RASI_TEMPLATE |\
  sed -r "s/ SEPARATOR_COLOR/$RGBA_DARK_CYAN/g"\ |
  sed -r "s/ BACKGROUND/$RGBA_BLACK/g"\ |
  sed -r "s/ FOREGROUND/$RGBA_GRAY/g"\ |
  sed -r "s/ SELECTED_FOREGROUND/$RGBA_BLACK/g"\ |
  sed -r "s/ SELECTED_BACKGROUND/$RGBA_GRAY/g"\
  `

echo "$NEW_ROFI_FILE" > $ROFI_WAL_RASI

convertColorCodeToHex() {
  RGB=$(echo $1 | sed "s/^#//g")
  printf "$RGB"
}

HEX_BLACK=$(convertColorCodeToHex $BLACK)
HEX_DARK_RED=$(convertColorCodeToHex $DARK_RED)
HEX_DARK_GREEN=$(convertColorCodeToHex $DARK_GREEN)
HEX_DARK_YELLOW=$(convertColorCodeToHex $DARK_YELLOW)
HEX_DARK_BLUE=$(convertColorCodeToHex $DARK_BLUE)
HEX_DARK_MAGENTA=$(convertColorCodeToHex $DARK_MAGENTA)
HEX_DARK_CYAN=$(convertColorCodeToHex $DARK_CYAN)
HEX_BRIGHT_BLACK=$(convertColorCodeToHex $BRIGHT_BLACK)
HEX_GRAY=$(convertColorCodeToHex $GRAY)
HEX_RED=$(convertColorCodeToHex $RED)
HEX_GREEN=$(convertColorCodeToHex $GREEN)
HEX_YELLOW=$(convertColorCodeToHex $YELLOW)
HEX_BLUE=$(convertColorCodeToHex $BLUE)
HEX_MAGENTA=$(convertColorCodeToHex $MAGENTA)
HEX_CYAN=$(convertColorCodeToHex $CYAN)
HEX_LIGHT_GRAY=$(convertColorCodeToHex $LIGHT_GRAY)

# generate alacritty file'
NEW_ALACRITTY_FILE=`cat $ALACRITTY_TEMPLATE |\
  sed -r "s/HEX_BLACK/'0x$HEX_BLACK'/g"\ |
  sed -r "s/HEX_DARK_RED/'0x$HEX_DARK_RED'/g"\ |
  sed -r "s/HEX_DARK_GREEN/'0x$HEX_DARK_GREEN'/g"\ |
  sed -r "s/HEX_DARK_YELLOW/'0x$HEX_DARK_YELLOW'/g"\ |
  sed -r "s/HEX_DARK_BLUE/'0x$HEX_DARK_BLUE'/g"\ |
  sed -r "s/HEX_DARK_MAGENTA/'0x$HEX_DARK_MAGENTA'/g"\ |
  sed -r "s/HEX_DARK_CYAN/'0x$HEX_DARK_CYAN'/g"\ |
  sed -r "s/HEX_BRIGHT_BLACK/'0x$HEX_BRIGHT_BLACK'/g"\ |
  sed -r "s/HEX_GRAY/'0x$HEX_GRAY'/g"\ |
  sed -r "s/HEX_RED/'0x$HEX_RED'/g"\ |
  sed -r "s/HEX_GREEN/'0x$HEX_GREEN'/g"\ |
  sed -r "s/HEX_YELLOW/'0x$HEX_YELLOW'/g"\ |
  sed -r "s/HEX_BLUE/'0x$HEX_BLUE'/g"\ |
  sed -r "s/HEX_MAGENTA/'0x$HEX_MAGENTA'/g"\ |
  sed -r "s/HEX_CYAN/'0x$HEX_CYAN'/g"\ |
  sed -r "s/HEX_LIGHT_GRAY/'0x$HEX_LIGHT_GRAY'/g"\
  `

echo "$NEW_ALACRITTY_FILE" > $ALACRITTY

# generate kitty file'
NEW_KITTY_FILE=`cat $KITTY_TEMPLATE |\
  sed -r "s/BLACK/$BLACK/g"\ |
  sed -r "s/DARK_RED/$DARK_RED/g"\ |
  sed -r "s/DARK_GREEN/$DARK_GREEN/g"\ |
  sed -r "s/DARK_YELLOW/$DARK_YELLOW/g"\ |
  sed -r "s/DARK_BLUE/$DARK_BLUE/g"\ |
  sed -r "s/DARK_MAGENTA/$DARK_MAGENTA/g"\ |
  sed -r "s/DARK_CYAN/$DARK_CYAN/g"\ |
  sed -r "s/BRIGHT_BLACK/$BRIGHT_BLACK/g"\ |
  sed -r "s/GRAY/$GRAY/g"\ |
  sed -r "s/RED/$RED/g"\ |
  sed -r "s/GREEN/$GREEN/g"\ |
  sed -r "s/YELLOW/$YELLOW/g"\ |
  sed -r "s/BLUE/$BLUE/g"\ |
  sed -r "s/MAGENTA/$MAGENTA/g"\ |
  sed -r "s/CYAN/$CYAN/g"\ |
  sed -r "s/WHITE/$LIGHT_GRAY/g"\
  `

echo "$NEW_KITTY_FILE" > $KITTY
