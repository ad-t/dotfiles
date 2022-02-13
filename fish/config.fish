function fish_prompt
  eval $HOME/.config/dotfiles/terminal_theme.sh "$status"
end

# set gpg pinentry
set -x GPG_TTY (tty)
set -x COMPOSE_DOCKER_CLI_BUILD 1
set -x DOCKER_BUILDKIT 1

# set the right terminal type
set -x TERM "xterm"
set -x EDITOR "nvim"

# set autocompletion for gopass
source ~/.config/dotfiles/aliases

# set fzf default options
set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore node_modules -g "."'

function fish_greeting
  echo -n ""
end
