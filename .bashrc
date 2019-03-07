#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd

alias ls='ls -h1 --color=auto --group-directories-first'

PS1="\[\e[35m\][\[\e[36m\]\t\[\e[35m\]] [\[\e[32m\]$([[ ${EUID} -eq 0 ]] && echo -e \\[\\e[32m\\])\u\[\e[35m\]@\[\e[33m\]\h\[\e[0m\] \[\e[36m\]\w\[\e[35m\]]\[\e[0m\]\n\[\e[35m\][\[\e[36m\]\j\[\e[35m\]] \[\e[33m\]\$\[\e[0m\] "
PS2='\[\e[33m\][…] \$\[\e[0m\] '
