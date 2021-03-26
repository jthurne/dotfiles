#!/usr/bin/env bash
#
# iTerm2 setup script
#

# Install/update the iTerm2 shell integration:
echo
echo "Installing iTerm2's shell integration"
curl -s -L https://iterm2.com/shell_integration/zsh -o $DOTFILES/iterm2/shell_integration.zsh

exit 0
