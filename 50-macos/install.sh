#!/bin/sh
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"

if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.
echo
echo "Updating Apps through the Mac App Store"
sudo softwareupdate -i -a

echo "Setting reasonable MacOS defaults"
exec "${scriptdir}/set-defaults.sh"
