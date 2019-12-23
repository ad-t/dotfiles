function fish_prompt
  eval $HOME/.config/dotfiles/terminal_theme.sh "$status"
end

set -x GPG_TTY (tty)
