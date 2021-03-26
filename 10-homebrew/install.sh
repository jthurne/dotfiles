#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"

echo ""
# Check for Homebrew
if test ! $(which brew)
then
  echo "Installing Homebrew!"

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi

fi

# Run Homebrew through the Brewfile
echo "Updating/installing packages with Homebrew"
brew bundle --file="$scriptdir/Brewfile"

exit 0

