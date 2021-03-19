# Setup the shell integration with sdkman
#
# This technically not a completion file, but we do want this to be loaded pretty late, and completions.zsh files are loaded last.
#
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jhurne/.sdkman"
[[ -s "/Users/jhurne/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jhurne/.sdkman/bin/sdkman-init.sh"
