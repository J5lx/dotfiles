# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' special-dirs true
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

if [[ -a ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]] then
  source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
  [[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
  [[ -n ${key[Home]} ]]   && bindkey "${key[Home]}"   beginning-of-line
  [[ -n ${key[End]} ]]    && bindkey "${key[End]}"    end-of-line
fi

setopt autocd histignorespace globcomplete interactivecomments autocontinue \
       dvorak promptsubst extendedglob

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable bzr git hg svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' max-exports 10
zstyle ':vcs_info:*' unstagedstr "%F{yellow}"
zstyle ':vcs_info:*' formats "%F{green}%s%F{magenta}:%F{yellow}%R" "%F{cyan}/%S" "%u%b"

precmd() {
  vcs_info
  dirmsg=""
  [[ -n $vcs_info_msg_0_ ]] && dirmsg="$dirmsg${vcs_info_msg_0_//$HOME/~}"
  [[ $vcs_info_msg_1_ != "%F{cyan}/." ]] && dirmsg="$dirmsg$vcs_info_msg_1_"
  [[ -n $vcs_info_msg_2_ ]] && dirmsg="$dirmsg%F{magenta}@%F{green}$vcs_info_msg_2_"
  [[ -z $dirmsg ]] && dirmsg="%F{cyan}%~"
}

PS1=$'%F{magenta}[%F{cyan}%D{%T}%F{magenta}] [%F{green}%n%F{magenta}@%F{yellow}%M ${dirmsg}%F{magenta}]\n%F{yellow}%(!.#.$)%f '
RPS1=$'%(?..%F{red}[%?])%(1j. %F{magenta}[%F{cyan}%j%F{magenta}].)%f'
PS2=$'%F{yellow}%(!.#.$)%f '
RPS2=$'%F{magenta}[%F{cyan}…%F{magenta}]%f'
#TMOUT=1
#TRAPALRM() {
#  # Makes time in prompt update in real-time
#  zle reset-prompt
#}

alias ls='ls -1h --color --group-directories-first'
alias rldc='rdmd --compiler=ldc'

# OPAM configuration
. /home/jakob/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
