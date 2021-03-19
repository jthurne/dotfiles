# Put the GNU-based core utilities (grep, etc) on the PATH and MAN PATH _before_ the MacOS builtin versions
PATH="/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/grep/libexec/gnuman:/usr/local/opt/gnu-sed/libexec/gnuman:/usr/local/opt/coreutils/libexec/gnuman:$PATH"
