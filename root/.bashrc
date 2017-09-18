# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PS1='[\[\e[1;31m\]\u\[\e[m\]@\[\e[0;33m\]\h \[\e[1;36m\]\W\[\e[m\]]\$ '
