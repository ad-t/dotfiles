set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showdirtystate
set __fish_git_prompt_showuntrackedfiles
set __fish_git_prompt_char_stateseparator ' '

# prevent underline on paths
set fish_color_valid_path

source $HOME/.config/dotfiles/fish/theme.fish

function fish_prompt
  status_segment $status
  path_segment (prompt_pwd)
  git_segment (fish_git_prompt)
  set_color normal
  echo -n " "
end

function fish_right_prompt
  right_prompt
  set_color normal
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

# set up android-studio paths
set -x ANDROID_HOME "$HOME/Android/Sdk"
fish_add_path "$ANDROID_HOME/platform-tools"
fish_add_path "$HOME/.yarn/bin"
fish_add_path "$HOME/.nvm/versions/node/v16.16.0/bin"

function nvm
  set -x NVM_DIR "$HOME/.nvm"
  bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
end

function fish_greeting
  echo -n ""
end
