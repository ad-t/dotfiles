#!/usr/bin/env python

import cv2 as cv
import numpy
import os


cwd = os.getcwd()
image_dir = '/images'
bg = cv.imread(cwd + image_dir + '/background.png')

for iterations in range(5):
    bg = cv.blur(bg, (25, 25))

cv.imwrite(cwd + image_dir + '/blurred.png', bg)
exit(0)
