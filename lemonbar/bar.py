#!/usr/bin/env python3

import os
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
    try:
        percentage = splitString[1]
    except:
        return 'Unavailable'
    if (len(splitString) > 2):
        if re.search(r'zero rate', splitString[2]):
            timeRemaining = "zero rate"
        else:
            timeRemaining = re.sub(r' remaining', '', splitString[2])
            timeRemaining = re.sub(r' until charged', '', timeRemaining)
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

def getBspwmWorkspaces(cwd, backgroundColor):
    colors = Colors()
    ws = ""
    ws += colors.backgroundColor(backgroundColor)
    ws += colors.foregroundColor(colors.color0)
    ws += colors.swapForegroundBackground()
    rawWorkspaces = runShellCommand("bspc wm -g")
    for block in rawWorkspaces.split(':'):
        firstLetter = block[0]
        desktopName = block[1:]
        # free
        if re.match(r'^f', firstLetter):
            ws += " {} ".format(desktopName)
        # focussed free
        elif re.match(r'^F', firstLetter):
            ws += colors.swapForegroundBackground()
            ws += " {} ".format(desktopName)
            ws += colors.swapForegroundBackground()
        # occupied
        elif re.match(r'^o', firstLetter):
            ws += "%{+u}"
            ws += " {} ".format(desktopName)
            ws += "%{-u}"
        # occupied and focused
        elif re.match(r'^O', firstLetter):
            ws += colors.swapForegroundBackground()
            ws += " {} ".format(desktopName)
            ws += colors.swapForegroundBackground()
        # urgent
        elif re.match(r'^u', firstLetter):
            ws += " [urgent] "
        # urgent and focussed
        elif re.match(r'^U', firstLetter):
            ws += " [focussed&urgent] "
        # layout
        elif re.match(r'^L', firstLetter):
            # tiling
            if re.match(r'^LT$', block):
                ws += " tiled ".format(block)
            # monocle
            elif re.match(r'^LM$', block):
                ws += " monocle ".format(block)
            else:
                ws += " layout unknown ({}) ".format(block)
        elif re.match(r'^[LTG]', firstLetter):
            ws += " [{}] ".format(block)
        elif re.match(r'^[LTG]', firstLetter):
            ws += " [{}] ".format(block)
        else:
            continue
    # TODO: Extend this further to allow for a count of windows on a single desktop
    ws += colors.swapForegroundBackground()
    return ws

def getNetworkTraffic():
    pathName = os.path.expanduser(f"~/.config/dotfiles/utils/")
    interfaces = set([ re.sub(r'\.[rt]x\.data', '', file) for file in os.listdir(pathName) if os.path.isfile(os.path.join(pathName, file)) and re.search(r'[a-z0-9]+\.[rt]x\.data', file) ])
    # filter out duplicates
    finalNetworkString = ""
    for interface in interfaces:
        pathName = os.path.expanduser(f"~/.config/dotfiles/utils/{interface}")
        with open(f"{pathName}.rx.data") as rx_file:
            rx = int(rx_file.read())
        with open(f"{pathName}.tx.data") as tx_file:
            tx = int(tx_file.read())
        rx_KBps = rx / 1024
        tx_KBps = tx / 1024
        networkString = "%s: d-%.2fk, u-%.2fk" % (interface, rx_KBps, tx_KBps)
        # finalNetworkString += "%{+u}"
        finalNetworkString += networkString
        # finalNetworkString += "%{-u}"
    return finalNetworkString

colors = Colors()

def main():
    accentColor = colors.color4
    bar = ""
    bar += getBspwmWorkspaces(cwd, accentColor)
    bar += colors.swapForegroundBackground()
    bar += colors.centerAlign()
    bar += getDate()
    bar += colors.rightAlign()
    bar += " "
    bar += getPrimaryDiskUsage()
    bar += " "
    bar += colors.swapForegroundBackground()
    bar += " "
    bar += getNetworkTraffic()
    bar += " "
    bar += colors.swapForegroundBackground()
    bar += " "
    bar += getBatteryStatus()
    bar += " "
    bar += colors.swapForegroundBackground()
    bar += " "
    bar += whoami()
    bar += " "
    bar += colors.foregroundColor("-")
    bar += colors.backgroundColor("-")
    bar += "\n"
    # print(bar, file=sys.stderr)
    print(bar)

if __name__ == '__main__':
    main()
