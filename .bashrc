# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export PS1='[\[\e[1;32m\]\u\[\e[m\]@\[\e[0;33m\]\h \[\e[1;36m\]\W\[\e[m\]]\$ '
export HISTCONTROL=ignorespace
