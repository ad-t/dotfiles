#!/usr/bin/env python3

import subprocess
import time

class Glyphs:
    # from: https://github.com/ryanoasis/powerline-extra-symbols
    leftArrow = "\ue0b0"
    leftThinArrow = "\ue0b1"
    rightArrow = "\ue0b2"
    rightThinArrow = "\ue0b3"

def runShellCommand(cmd: str):
    return subprocess.run([cmd], shell=True, stdout=subprocess.PIPE).stdout.decode().rstrip()

def getDate():
    return runShellCommand("date")

def main():
    bar = "{}".format(leftArrow)
    bar += getDate()
    print(bar)

if __name__ == '__main__':
    main()
