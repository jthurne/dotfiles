#!/bin/bash
#
# Installs Oh My ZSH!
#
# The official install script has a bunch of code to check for things
# that we can skip because we know we're running on MacOS. The official
# install script also takes over the .zshrc, which of course, we don't
# want to do because we're managing that ourselves.
# 
# So all we really need to do is just clone the ohmyzsh git repo.

export ZSH=~/.oh-my-zsh

if [ ! -d $ZSH ]; then
  REPO=ohmyzsh/ohmyzsh
  REMOTE=https://github.com/${REPO}.git
  BRANCH=master

  git clone -c core.eol=lf -c core.autocrlf=false \
    -c fsck.zeroPaddedFilemode=ignore \
    -c fetch.fsck.zeroPaddedFilemode=ignore \
    -c receive.fsck.zeroPaddedFilemode=ignore \
    --depth=1 --branch "$BRANCH" "$REMOTE" "$ZSH"
fi

