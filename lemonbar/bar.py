#!/usr/bin/env python3

import subprocess
import time
import sys
import re

cwd = sys.argv[1]

class Glyphs:
    # from: https://github.com/ryanoasis/powerline-extra-symbols
    leftArrow = "\ue0b0"
    leftThinArrow = "\ue0b1"
    rightArrow = "\ue0b2"
    rightThinArrow = "\ue0b3"

class Colors:
    def __init__(self):
        self.background = getXresourceValue(cwd, "background")
        self.color0 = getXresourceValue(cwd, "color0")
        self.color1 = getXresourceValue(cwd, "color1")
        self.color2 = getXresourceValue(cwd, "color2")
        self.color3 = getXresourceValue(cwd, "color3")
        self.color4 = getXresourceValue(cwd, "color4")
        self.color5 = getXresourceValue(cwd, "color5")
        self.color6 = getXresourceValue(cwd, "color6")
        self.color7 = getXresourceValue(cwd, "color7")

    def backgroundColor(self, color):
        string = "%{"
        string += "B%s" % (color)
        string += "}"
        return string

    def foregroundColor(self, color):
        string = "%{"
        string += "F%s" % (color)
        string += "}"
        return string

    def swapForegroundBackground(self):
        return "%{R}"

    def leftAlign(self):
        return "%{l}"

    def centerAlign(self):
        return "%{c}"

    def rightAlign(self):
        return "%{r}"

def getXresourceValue(cwd, prop):
    string = '{}/get_xresource_value.sh "{}"'.format(cwd, prop)
    return runShellCommand(string)

def runShellCommand(cmd: str):
    return subprocess.run([cmd], shell=True, stdout=subprocess.PIPE).stdout.decode().rstrip()

def getDate():
    return runShellCommand('date "+%Y-%m-%d %H:%M:%S"')

def currentWorkspace():
    return runShellCommand('tail -n 1 /tmp/xmonad-cws')

def whoami():
    return runShellCommand('whoami')

def fixWorkspaceInfoFromXMonad(xmonadWorkspaceString):
    split = xmonadWorkspaceString.split(' : ')
    return ' : '.join(split[0:2])
    return re.sub(r': [^:]*$', '', xmonadWorkspaceString)

def getWorkspaces(cwd):
    workspaceString = ""
    with open('{}/workspaces.txt'.format(cwd)) as workspaces:
        for line in workspaces:
            workspaceString += line
    return fixWorkspaceInfoFromXMonad(workspaceString)

def main():
    colors = Colors()
    bar = ""
    bar += colors.backgroundColor(colors.color3)
    bar += colors.foregroundColor(colors.color0)
    bar += " "
    bar += " "
    bar += getWorkspaces(cwd)
    bar += " "
    bar += colors.swapForegroundBackground()
    bar += "{}".format(Glyphs.leftArrow)
    bar += " "
    bar += colors.centerAlign()
    bar += getDate()
    bar += colors.rightAlign()
    bar += "{}".format(Glyphs.rightArrow)
    bar += colors.swapForegroundBackground()
    bar += " "
    bar += whoami()
    bar += " "
    bar += colors.foregroundColor("-")
    bar += colors.backgroundColor("-")
    bar += "\n"
    print(bar)

if __name__ == '__main__':
    main()
