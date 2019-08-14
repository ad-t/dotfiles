#!/bin/sh

xrdb -query | egrep "$1" | head -n 1 | tr '\t' ' ' | sed "s/.*: *//g"
