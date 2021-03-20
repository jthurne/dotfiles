#!/usr/bin/env bash
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
export ZSH_CUSTOM=$ZSH/custom

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

##### Install the Powerlevel10k Theme

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  # Install Powerlevel10k itself
  git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

  # Install the Meslo Nerd Font
  cd ~/Library/Fonts && {
    curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf';
    curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf';
    curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf';
    curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf';
    cd -; }
fi

##### Install zsh-autosuggestions

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

