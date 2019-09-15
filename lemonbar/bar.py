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
        self.color8 = getXresourceValue(cwd, "color8")
        self.color9 = getXresourceValue(cwd, "color9")
        self.color10 = getXresourceValue(cwd, "color10")
        self.color11 = getXresourceValue(cwd, "color11")
        self.color12 = getXresourceValue(cwd, "color12")
        self.color13 = getXresourceValue(cwd, "color13")
        self.color14 = getXresourceValue(cwd, "color14")
        self.color15 = getXresourceValue(cwd, "color15")

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

def getPrimaryDiskUsage():
    drive = '/dev/sda1'
    dfResult = runShellCommand('df {} --output=pcent | tail -n 1'.format(drive)).lstrip()
    diskUsageString = '/: {}'.format(dfResult)
    return diskUsageString

def getBatteryStatus():
    rawString = runShellCommand('acpi')
    if re.search(r'unavailable', rawString):
        return 'wall powered'
    # filter out battery number
    batteryString = re.sub(r'^[^:]+: ', '', rawString)
    splitString = batteryString.split(', ')
    batteryString = str(splitString)
    chargingStatus = None
    if re.match(r'Discharging', splitString[0]):
        # not charging
        chargingStatus = 'bat'
    else:
        # charging
        chargingStatus = 'chrg'
    percentage = splitString[1]
    if (len(splitString) > 2):
        timeRemaining = re.sub(r' remaining', '', splitString[2])
    else:
        timeRemaining = "full"
    return '{}: {} ({})'.format(chargingStatus, percentage, timeRemaining)

def whoami():
    return runShellCommand('whoami')

def separatorLeft():
    return "{}".format(\
                        Glyphs.leftArrow,\
                      )

def separatorRight():
    return "{}".format(\
                         Glyphs.leftArrow,\
                       )

def formatWorkspaces(workspaceString, focusColor, regularColor):
    spaces = workspaceString.split(' ')
    formattedString = ""
    for space in spaces:
        if re.match(r'\[', space):
            space = re.sub('[\[\]]', '', space)
            formattedString += "{}{}{} {}{} {}{}{}{}".format(\
                                                    colors.backgroundColor(focusColor),\
                                                    colors.foregroundColor(colors.color0),\
                                                    separatorRight(),\
                                                    space,\
                                                    colors.foregroundColor(focusColor),\
                                                    colors.backgroundColor(colors.color0),\
                                                    separatorLeft(),\
                                                    colors.backgroundColor(regularColor),\
                                                    colors.foregroundColor(colors.color0),\
                                                    )
        else:
            space = re.sub('[<>]', '', space)
            formattedString += "{} {} {}{}{}{}".format(\
                                                separatorRight(),\
                                                space,\
                                                colors.foregroundColor(regularColor) + colors.backgroundColor(colors.color0),\
                                                separatorLeft(),\
                                                colors.backgroundColor(regularColor),\
                                                colors.foregroundColor(colors.color0),\
                                                )
    return formattedString

def fixWorkspaceInfoFromXMonad(xmonadWorkspaceString, focusColor, regularColor):
    xmonadWorkspaceString = re.sub(r'\n', '', xmonadWorkspaceString)
    split = xmonadWorkspaceString.split(' : ')
    return "{}{}{}{}{}{}{} {}".format(\
                                    colors.foregroundColor(colors.color3),\
                                    colors.backgroundColor(colors.color0),\
                                    separatorLeft(),\
                                    colors.backgroundColor(regularColor),\
                                    colors.foregroundColor(colors.color0),\
                                    formatWorkspaces(split[0], focusColor, regularColor),\
                                    colors.backgroundColor(regularColor) + colors.foregroundColor(colors.color0) + separatorRight(),\
                                    split[1],\
                                )
    return re.sub(r': [^:]*$', '', xmonadWorkspaceString)

def getWorkspaces(cwd, focusColor, regularColor):
    workspaceString = ""
    with open('{}/workspaces.txt'.format(cwd)) as workspaces:
        for line in workspaces:
            workspaceString += line
    return fixWorkspaceInfoFromXMonad(workspaceString, focusColor, regularColor)

colors = Colors()

def main():
    focusColor = colors.color7
    backgroundColor = colors.color5
    bar = ""
    bar += colors.backgroundColor(backgroundColor)
    bar += colors.foregroundColor(colors.color0)
    bar += getWorkspaces(cwd, focusColor, backgroundColor)
    bar += " "
    bar += colors.swapForegroundBackground()
    bar += "{}".format(Glyphs.leftArrow)
    bar += " "
    bar += colors.centerAlign()
    bar += getDate()
    bar += colors.rightAlign()
    bar += "{}".format(Glyphs.rightThinArrow)
    bar += " "
    bar += getPrimaryDiskUsage()
    bar += " "
    bar += colors.swapForegroundBackground()
    bar += colors.backgroundColor(colors.color3)
    bar += colors.swapForegroundBackground()
    bar += "{}".format(Glyphs.rightArrow)
    bar += colors.swapForegroundBackground()
    bar += " "
    bar += getBatteryStatus()
    bar += " "
    bar += colors.backgroundColor(colors.color5)
    bar += colors.swapForegroundBackground()
    bar += colors.backgroundColor(colors.color3)
    bar += "{}".format(Glyphs.rightArrow)
    bar += colors.swapForegroundBackground()
    bar += " "
    bar += colors.foregroundColor(colors.color0)
    bar += whoami()
    bar += " "
    bar += "{}".format(Glyphs.rightArrow)
    bar += colors.swapForegroundBackground()
    bar += colors.foregroundColor(colors.color3)
    bar += "{}".format(Glyphs.rightArrow)
    bar += colors.foregroundColor("-")
    bar += colors.backgroundColor("-")
    bar += "\n"
    # print(bar, file=sys.stderr)
    print(bar)

if __name__ == '__main__':
    main()
