#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"

echo ""
# Check for Homebrew
if test ! $(which brew)
then
  echo "Installing Homebrew!"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -f "/usr/loca/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# Homebrew 6.0+ requires non-official taps to be explicitly trusted with
# `brew trust` before their formulae/casks will load; otherwise `brew bundle`
# silently skips them. Trust the taps this Brewfile declares. Idempotent.
grep -E "^[[:space:]]*tap " "${script_dir}/Brewfile" | awk -F"'" '{print $2}' | while read -r tap; do
  [ -n "$tap" ] && brew trust --tap "$tap"
done

# Run Homebrew through the Brewfile
echo "Updating/installing packages with Homebrew"
brew bundle --file="${script_dir}/Brewfile"

exit 0
