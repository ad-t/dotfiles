set __fish_git_prompt_show_informative_status true
set __fish_git_prompt_showdirtystate true
set __fish_git_prompt_showuntrackedfiles true
set __fish_git_prompt_char_stateseparator ' '

# prevent underline on paths
set fish_color_valid_path

source $HOME/.config/dotfiles/fish/theme.fish

function fish_prompt
  status_segment $status
  path_segment (prompt_pwd) (fish_git_prompt)
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
set -x EDITOR "nvim"

# set GTK scaling
# set -x GDK_DPI_SCALE 1.25
# set QT scaling
set -x QT_SCALE_FACTOR 1.5

# set autocompletion for gopass
source ~/.config/dotfiles/aliases

# # set fzf default options
set -x FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git'

set THM_BG "#181616"
set THM_BLACK "#0D0C0C"
set THM_BLACK2 "#12120F"
set THM_BRIGHTBLACK "#A6A69C"
set THM_RED "#C4746E"
set THM_GREEN "#8A9A7B"
set THM_YELLOW "#C4B28A"
set THM_BLUE "#8BA4B0"
set THM_MAGENTA "#A292A3"
set THM_CYAN "#8EA4A2"
set THM_GRAY "#C8C093"
set THM_FG "#C5C9C5"
set THM_DARKBLUE "#2d4f67"

# kanagawa dragon theme
set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS\
    --padding=1,2\
    --color=gutter:$THM_BG\
    --color=fg:$THM_FG,bg:$THM_BG,hl:$THM_DARKBLUE\
    --color=fg+:$THM_BG,bg+:$THM_DARKBLUE,hl+:$THM_BLUE\
    --color=info:$THM_MAGENTA,prompt:$THM_DARKBLUE,pointer:$THM_BLUE\
    --color=marker:$THM_MAGENTA,spinner:$THM_GREEN,header:$THM_BG"

# set java version
set -x JAVA_HOME "/usr/lib/jvm/java-11-openjdk-amd64"

# set up android-studio paths
set -x ANDROID_HOME "$HOME/Android/Sdk"
fish_add_path "$ANDROID_HOME/platform-tools"
fish_add_path "$HOME/.yarn/bin"
# node 16
# fish_add_path "$HOME/.nvm/versions/node/v16.16.0/bin"
# node 18
fish_add_path "$HOME/.nvm/versions/node/v18.10.0/bin"

# set up CUDA
fish_add_path "/usr/local/cuda-12.1/bin"
# this causes nix things to break, add this back on a case-by-case basis
# set -x LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu
# set -x NIX_LD "/usr/lib/x86_64-linux-gnu"

function nvm
  set -x NVM_DIR "$HOME/.nvm"
  bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
end

function fish_greeting
  echo -n ""
end
