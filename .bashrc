#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd

alias ls='ls -h1 --color=auto --group-directories-first'

PS1="\[\033[35m\][\[\033[36m\]\t\[\033[35m\]] [\[\033[32m\]$([[ ${EUID} -eq 0 ]] && echo -e \\[\\033[32m\\])\u\[\033[35m\]@\[\033[33m\]\h\[\033[0m\] \[\033[36m\]\w\[\033[35m\]]\[\033[0m\]\n\[\033[35m\][\[\033[36m\]\j\[\033[35m\]] \[\033[33m\]\$\[\033[0m\] "
PS2='\[\033[33m\][…] \$\[\033[0m\] '
