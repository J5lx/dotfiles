# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-list all
zstyle ':completion:*' file-sort name
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu on select interactive
zstyle ':completion:*' path-completion off
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename '/home/jakob/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

zkbdfile="${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${${DISPLAY:t}:-${VENDOR}-${OSTYPE}}"
if [[ ! -a "${zkbdfile}" ]] then
  read -k 1 runzkbd"?No keyboard configuration found at ${zkbdfile}. Run zkbd? [Y/n] "
  if [[ "${runzkbd:l}" = [$'\ny'] ]] then
    autoload -Uz zkbd
    zkbd
  fi
  if [[ "${runzkbd}" != $'\n' ]] echo
fi
if [[ -a "${zkbdfile}" ]] then
  source "${zkbdfile}"
  [[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
  [[ -n ${key[Home]} ]]   && bindkey "${key[Home]}"   beginning-of-line
  [[ -n ${key[End]} ]]    && bindkey "${key[End]}"    end-of-line
fi
unset zkbdfile runzkbd

setopt autocd completeinword histignorespace globcomplete interactivecomments \
       autocontinue dvorak promptsubst extendedglob

autoload -Uz vcs_info
# Use prompt escapes?
zstyle ':vcs_info:*' enable bzr git hg svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' unstagedstr "%F{y}"
zstyle ':vcs_info:*' patch-format "(%n/%a)" # TODO: what about hg bookmarks?
zstyle ':vcs_info:*' nopatch-format "(%n/%a)"
#zstyle ':vcs_info:*' formats "%F{g}%s%F{m}:%F{c}\${(D)\${:-'%R'}}%F{blu}\${(q)\${(Q)\":-'/%S'\"}%/.}%F{m}@%F{g}%u%b"
#zstyle ':vcs_info:*' actionformats "%F{g}%s%F{m}:%F{c}\${(D)\${:-'%R'}}%F{blu}/\${\${:-'/%S'}%/.}%F{m}@%F{g}%u%b%F{m}|%F{c}%a%m"
zstyle ':vcs_info:*' formats "%F{g}%s%F{m}:%F{c}%R" "%F{blu}/%S" "%F{m}@%F{g}%u%b"
zstyle ':vcs_info:*' actionformats "%F{g}%s%F{m}:%F{c}%R" "%F{blu}/%S" "%F{m}@%F{g}%u%b%F{m}|%F{c}%a%m"
zstyle ':vcs_info:*' nvcsformats "" "" "%F{c}%~"

precmd() {
  vcs_info
  dirmsg=""
  [[ -n $vcs_info_msg_0_ ]] && dirmsg="${dirmsg}${vcs_info_msg_0_//$HOME/~}"
  [[ -n $vcs_info_msg_1_ ]] && dirmsg="${dirmsg}${vcs_info_msg_1_%/.}"
  [[ -n $vcs_info_msg_2_ ]] && dirmsg="${dirmsg}${vcs_info_msg_2_}"
}

PS1=$'\e]2;%n@%M:%~\a%F{m}[%F{c}%D{%T}%F{m}] [%(!.%F{r}.%F{g})%n%F{m}@%F{blu}%M ${dirmsg}%F{m}]\n%B%F{blu}%!%b%(!.%F{r}#.%F{g}$)%f '
RPS1=$'%(?..%F{r}[%?])%(1j. %F{m}[%F{c}%j%F{m}].)%f'
PS2=$'%F{c}%_%(1_..%(!.%F{r}#.%F{g}$))%f '
RPS2=$'%F{m}[%F{c}…%F{m}]%f'
#TMOUT=1
#TRAPALRM() {
#  # Makes time in prompt update in real-time
#  zle reset-prompt
#}

alias ls='ls -h1 --color --group-directories-first'
alias rldc='rdmd --compiler=ldc'

. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if (($+commands[rbenv])); then
  eval "$(rbenv init -)"
fi

export GPG_TTY=$(tty)

# OPAM configuration
. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
