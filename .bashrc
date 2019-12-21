bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# aliases
alias up="cd .."
alias ..="cd .."
alias ...="cd ../.."

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
  RETVAL="$?"
  PS1="$(~/.config/dotfiles/terminal_theme.sh $RETVAL)"
}

