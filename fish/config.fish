set __fish_git_prompt_show_informative_status true
set __fish_git_prompt_showdirtystate true
set __fish_git_prompt_showuntrackedfiles true
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
set -x EDITOR "nvim"

# set GTK scaling
# set -x GDK_DPI_SCALE 1.25
# set QT scaling
set -x QT_SCALE_FACTOR 2

# set autocompletion for gopass
source ~/.config/dotfiles/aliases

# # set fzf default options
# set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore node_modules --ignore .next -g "."'

# gruvbox theme

# set TERMINAL_BACKGROUND "#282828"
# set DARK0 "#0D0E0F"
# set DARK "#0D0E0F"
# set BACKGROUND_DARK "#171A1A"
# set BACKGROUND "#1D2021"
# set BACKGROUND_LIGHT "#32302F"
# set FOREGROUND "#EBDBB2"
# set GRAY "#DEDEDE"
# set MEDIUM_GRAY "#504945"
# set COMMENT "#665C54"
# set MILK "#E7D7AD"
# set ERROR_RED "#CC241D"
# set RED "#FB4934"
# set ORANGE "#D65D0E"
# set BRIGHT_YELLOW "#FABD2F"
# set SOFT_YELLOW "#EEBD35"
# set PINK "#D4879C"
# set MAGENTA "#B16286"
# set SOFT_GREEN "#98971A"
# set FOREST_GREEN "#689D6A"
# set CLEAN_GREEN "#8EC07C"
# set BLUE_GRAY "#458588"
# set DARK_GRAY "#83A598"
# set LIGHT_BLUE "#7FA2AC"

# catppuccin theme
# set TERMINAL_BACKGROUND "#1e1e2e"
# set FOREGROUND "#cdd6f4"
# set GRAY "#cdd6f4"
# set ERROR_RED "#f5e0dc"
# set ORANGE "#cba6f7"
# set BRIGHT_YELLOW "#f38ba8"
# set LIGHT_BLUE "#cba67f"
# set MEDIUM_GRAY "#313244"
#
# set -x FZF_DEFAULT_OPTS "\
# --color=fg:$FOREGROUND \
# --color=bg:$TERMINAL_BACKGROUND \
# --color=hl:$BRIGHT_YELLOW \
# --color=fg+:bold:$GRAY \
# --color=bg+:$MEDIUM_GRAY \
# --color=gutter:$TERMINAL_BACKGROUND \
# --color=hl+:$BRIGHT_YELLOW \
# --color=info:$ORANGE \
# --color=prompt:$LIGHT_BLUE \
# --color=spinner:$BRIGHT_YELLOW \
# --color=pointer:bold:$BRIGHT_YELLOW \
# --color=marker:$ERROR_RED \
# --color=header:$ORANGE \
# "
# set -x FZF_DEFAULT_OPTS "\
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# nord theme
# set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS\
#     --padding=5%\
#     --color=gutter:#3b4252\
#     --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1\
#     --color=fg+:#e5e9f0,bg+:#434c5e,hl+:#81a1c1\
#     --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac\
#     --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b"

# gruvbox theme
set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS\
    --padding=1,2\
    --color=gutter:#282828\
    --color=fg:#d4be98,bg:#282828,hl:#665c54\
    --color=fg+:#d4be98,bg+:#45403d,hl+:#928374\
    --color=info:#e78a4e,prompt:#928374,pointer:#a9b665\
    --color=marker:#b38ead,spinner:#a9b665,header:#665c54"

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
