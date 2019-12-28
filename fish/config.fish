function fish_prompt
  eval $HOME/.config/dotfiles/terminal_theme.sh "$status"
end

# set gpg pinentry
set -x GPG_TTY (tty)

# set autocompletion for gopass
gopass completion fish | source
source ~/.config/dotfiles/aliases

function fish_greeting
  echo -n ""
end
