function fish_prompt
  eval $HOME/.config/dotfiles/terminal_theme.sh "$status"
end

# set gpg pinentry
set -x GPG_TTY (tty)
set -x COMPOSE_DOCKER_CLI_BUILD 1
set -x DOCKER_BUILDKIT 1

# set the right terminal type
set -x TERM "xterm"

# set autocompletion for gopass
gopass completion fish | source
source ~/.config/dotfiles/aliases

function fish_greeting
  echo -n ""
end
