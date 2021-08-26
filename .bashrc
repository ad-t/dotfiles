bind 'set show-all-if-ambiguous on'
bind 'TAB: menu-complete'
bind "set menu-complete-display-prefix on"
bind "set colored-completion-prefix"

# aliases
alias up="cd .."
alias ..="cd .."
alias ...="cd ../.."

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
  RETVAL="$?"
  PS1="$(~/.config/dotfiles/terminal_theme.sh $RETVAL)"
}

# load completions
source /etc/profile.d/bash_completion.sh

# colours
force_color_prompt=yes

# fix gpg
export GPG_TTY=$(tty)
