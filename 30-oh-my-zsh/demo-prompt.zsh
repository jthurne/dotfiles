# Reconfigures the prompt for something that is appropriate for demos
function demo-prompt() {
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    os_icon                 # os identifier
    dir                     # current directory
    # =========================[ Line #2 ]=========================
    newline                 # \n
    prompt_char             # prompt symbol
  )
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last

  p10k reload
  if zle; then
    zle push-input
    zle accept-line
  fi
}

