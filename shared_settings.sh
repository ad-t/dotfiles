#!/bin/sh

source $HOME/.config/dotfiles/aliases

# set gpg pinentry
export GPG_TTY=$(tty)
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

# set the right terminal type
export TERM="xterm"
export EDITOR="nvim"

# set fzf default options
export FZF_DEFAULT_COMMAND='ag --hidden --ignore node_modules --ignore ".next" --ignore ".git" -g "."'
export AG_DEFAULT_FLAGS='-i --hidden --ignore node_modules --ignore .git --ignore dist'
