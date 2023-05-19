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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Run Homebrew through the Brewfile
echo "Updating/installing packages with Homebrew"
brew bundle --file="$scriptdir/Brewfile"

exit 0

