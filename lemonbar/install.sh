#!/bin/sh -x

BUILD_REPO_DIR="$HOME/build_repos/"
LEMONBAR_XFT_REPO="git@github.com:drscream/lemonbar-xft.git"
LEMONBAR_XFT_DIR="lemonbar-xft"

# install deps
sudo apt install libx11-xcb-dev libxcb-xinerama0-dev

cd $BUILD_REPO_DIR &&
  git clone "$LEMONBAR_XFT_REPO" &&
  cd $LEMONBAR_XFT_DIR &&
  make &&
  sudo make install
