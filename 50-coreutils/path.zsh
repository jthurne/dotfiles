# Put the GNU-based core utilities (grep, etc) on the PATH and MAN PATH _before_ the MacOS builtin versions
PATH="$(brew --prefix grep)/gnubin:$(brew --prefix gnu-sed)/libexec/gnubin:$(brew --prefix coreutils)/libexec/gnubin:$PATH"
MANPATH="$(brew --prefix grep)/gnuman:$(brew --prefix gnu-sed)/libexec/gnuman:$(brew --prefix coreutils)/libexec/gnuman:$PATH"
