function __fish_printer_ender3_complete_commands
    echo "start"
    echo "stop"
end

set -l printer_commands ender3
complete -f -c printer -n "not __fish_seen_subcommand_from $printer_commands" -a ender3 -d 'ender3 printer'

# nested commands for specifically ender3
complete -f -c printer -n "__fish_seen_subcommand_from ender3; and not __fish_seen_subcommand_from (__fish_printer_ender3_complete_commands)" -a "(__fish_printer_ender3_complete_commands)"

# An explanation of how this works:
#
#   If there's a list of commands for a particular executable and none of
#   those have been seen yet, `not __fish_seen_subcommand_from $list` will
#   present that list, with descriptions
#
#   For nested commands, we're making the condition
#       "we've seen command X, output the list of valid subcommands if we
#        haven't seen it yet"
#
#   Learnt this from this handy article:
#   https://medium.com/@fabioantunes/a-guide-for-fish-shell-completions-485ac04ac63c
