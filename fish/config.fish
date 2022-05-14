set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showdirtystate
set __fish_git_prompt_showuntrackedfiles
set __fish_git_prompt_char_stateseparator ' '

function fish_prompt
  eval $HOME/.config/dotfiles/fish/theme.fish "$status" "GIT" \"(fish_git_prompt)\"
end

function fish_right_prompt
  eval $HOME/.config/dotfiles/fish/theme.fish "$status" "RIGHT"
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
