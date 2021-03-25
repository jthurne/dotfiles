
# use CTRL-SPACE to accept auto suggestions instead of right-arrow
export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#forward-char}")
bindkey '^ ' autosuggest-accept

# Make suggestions first based on command history, and second based on autocomplete suggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
