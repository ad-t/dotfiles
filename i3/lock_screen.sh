#!/bin/sh

cd ~/.config/i3
scrot ./images/background.png
./blur.py
i3lock -i ./images/blurred.png
