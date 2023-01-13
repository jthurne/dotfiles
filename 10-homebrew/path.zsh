if [ -f "/usr/loca/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

