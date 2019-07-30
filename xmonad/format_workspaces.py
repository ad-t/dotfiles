#!/usr/bin/env python3

import re
import subprocess

bar_file = "/tmp/xmonad-bar"

def getColorCode(color: str):
    c = subprocess.run(["$HOME/.config/dotfiles/xmonad/get_xresource_value.sh %s" % (color)], shell=True, stdout=subprocess.PIPE).stdout.decode().rstrip()
    return c

def makePolybarColorFormatting(formatting: str, colorCode: str):
    return '%' + "{%s%s}" % (formatting, colorCode)

def main():
    cws = subprocess.run(["tail -n 1 /tmp/xmonad-cws"], shell=True, stdout=subprocess.PIPE).stdout.decode().rstrip()

    # workspaces = subprocess.run(["tail -n 1 /tmp/xmonad-ws"], shell=True, stdout=subprocess.PIPE).stdout.decode().rstrip()

    # workspaces = re.sub(cws, '', workspaces)

    active_background = getColorCode('color3')
    string = "{} {} ".format(
        makePolybarColorFormatting('B', active_background),
        cws
    )

    string = re.sub(r', 1.*', '', string)

    cmd = "echo \"%s\" >> %s" % (string, bar_file)
    subprocess.run([cmd], shell=True).stdout

if __name__ == '__main__':
    main()
