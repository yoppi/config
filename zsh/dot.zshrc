# .zshrc

# misc. #{{{1
# Environment variable configuration 
export LANG=ja_JP.UTF-8

# for fakeclip.vim
case $OSTYPE in
  darwin*)
    export __CF_USER_TEXT_ENCODING=0x1F5:0x08000100:0
  ;;
esac

# Keybind configuration
#   * -e: emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e
#   goes to end of it)
#   * -v: vi like keybind. modal key editing.
bindkey -e
#bindkey -v

# Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=4294967296
SAVEHIST=4294967296

# zsh editor
autoload zed

# set subversion editor
export SVN_EDITOR=vim
export EDITOR=vim

# load user .zshrc configuration file
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

# load each project configuration file
if [ -d $HOME/.zsh/proj ]; then
  for envfile in $HOME/.zsh/proj/*; do
    source $envfile
  done
fi

# Completion configuration
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit



## Options #{{{1
# auto change directory
setopt auto_cd
# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd
# command correct edition before each completion attempt
setopt correct
# compacked complete list display
setopt list_packed
# no remove postfix slash of command line
setopt noautoremoveslash
# no beep sound when complete list displayed
setopt nolistbeep
#setopt auto_list
#setopt glob
#setopt interactive_comments
#setopt menu_complete
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt complete_aliases     # aliased ls needs if file/dir completions work





## Prompt #{{{1
# use zsh-git prompt
#setopt promptsubst

# Load the prompt theme system
#autoload -U promptinit
#promptinit

# Use the yoppi prompt theme
#rompt yoppi

autoload -Uz add-zsh-hook
autoload -Uz colors
colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionfromats '(%s-[%b|%a])'
zstyle ':vcs_info:svn:*' branchformat '%b:%r'

#autoload -Uz is-at-least
#if is-at-least 4.3.10; then
#  zstyle ':vcs_info:git:*' check-for-changes true
#  zstyle ':vcs_info:git:*' stagedstr "+"
#  zstyle ':vcs_info:git:*' unstagedstr "!"
#  zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
#  zstyle ':vcs_info:git:*' actionfromats '(%s)-[%b|%a] %c%u'
#fi

function _update_vcs_info_msg() {
  psvar=()
  vcs_info
  #LANG=en.US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{yellow}%1v%f|)"

coloratom() {
  local off=$1 atom=$2
  if [[ $atom[1] == [[:upper:]] ]]; then
    off=$(( $off + 60 ))
  fi
  echo $(( $off + $colorcode[${(L)atom}] ))
}
colorword() {
  local fg=$1 bg=$2 att=$3
  local -a s

  if [ -n "$fg" ]; then
    s+=$(coloratom 30 $fg)
  fi
  if [ -n "$bg" ]; then
    s+=$(coloratom 40 $bg)
  fi
  if [ -n "$att" ]; then
    s+=$attcode[$att]
  fi

  echo "%{"$'\e['${(j:;:)s}m"%}"
}

typeset -A colorcode # declaration of Array
colorcode[black]=0
colorcode[red]=1
colorcode[green]=2
colorcode[yellow]=3
colorcode[blue]=4
colorcode[magenta]=5
colorcode[cyan]=6
colorcode[white]=7
colorcode[default]=9
colorcode[k]=$colorcode[black]
colorcode[r]=$colorcode[red]
colorcode[g]=$colorcode[green]
colorcode[y]=$colorcode[yellow]
colorcode[b]=$colorcode[blue]
colorcode[m]=$colorcode[magenta]
colorcode[c]=$colorcode[cyan]
colorcode[w]=$colorcode[white]
colorcode[.]=$colorcode[default]

typeset -A attcode
attcode[none]=00
attcode[bold]=01
attcode[faint]=02
attcode[standout]=03
attcode[underline]=04
attcode[blink]=05
attcode[reverse]=07
attcode[conceal]=08
attcode[normal]=22
attcode[no-standout]=23
attcode[no-underline]=24
attcode[no-blink]=25
attcode[no-reverse]=27
attcode[no-conceal]=28

local -A pc
pc[default]='default'
pc[date]='cyan'
pc[time]='Blue'
pc[host]='Green'
pc[user]='Green'
pc[root]='Red'
pc[punc]='yellow'
pc[line]='magenta'
pc[hist]='green'
pc[path]='Cyan'
pc[shortpath]='default'
pc[rc]='red'
pc[scm_branch]='Cyan'
pc[scm_commitid]='Yellow'
pc[scm_status_dirty]='Red'
pc[scm_status_staged]='Green'
pc[#]='Yellow'
for cn in ${(k)pc}; do
  pc[${cn}]=$(colorword $pc[$cn])
done
pc[reset]=$(colorword . . 00)

local c_user 
local c_red=$'\e[31m'
local c_green=$'\e[32m'
case "$USER" in
  root)
    c_user="$pc[root]"
    ;;
  *)
    c_user="$pc[user]"
    ;;
esac
PROMPT="$c_user%n$pc[reset]@$pc[host]%m$pc[reset] "
PROMPT+="$pc[path]%(2~.%~.%/)$pc[reset]"
PROMPT+="
"
PROMPT+="/ _ /x $pc[#]%(!.#.<)$pc[reset]"

## Aliases #{{{1
case "${OSTYPE}" in
  darwin*)
    alias ls="ls -G -w"
    alias firefox="open -a Firefox"
    alias preview="open -a Preview"
    alias safari="open -a Safari"
    alias cot="open -a CotEditor"
    alias gvim="/Applications/MacVim.app/Contents/MacOS/Vim -g"
    alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
    ;;
  linux*)
    alias ls="ls --color --file-type"
    ;;
  cygwin*)
    alias ls="ls --color --file-type"
    alias open="cygstart"
esac

alias grep="grep --color=auto"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias lt="ls -lt"
alias ltr="ls -altr"
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias where="command -v"
alias j="jobs -l"
alias v="vim"
alias r="rails"
alias sp="rspec -c"

# for git
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias ge="git config -e"
alias gf="git fetch"
alias gg="git grep"
alias gl="git log"
alias gp="git push"
alias gsw="git show"
alias gvn="git svn"
alias gsh="git stash"
alias gshp="git stash pop"
alias gst="git status"

# for bazaar
alias b="bzr"

# for Mercurial
alias h="hg"
alias hs="hg status"
alias hd="hg diff"

# for secure!
alias cp="cp -i"
alias mv="mv -i"

## Search #{{{1
# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end





## Coloring #{{{1
zstyle ':completion:*' list-colors ''





## PATH #{{{1

if [ -d /usr/local/bin ]; then
  for bin in /usr/local/bin; do
    if [ -d $bin ]; then
      export PATH=$bin:$PATH
    fi
  done
fi

# for haskell application
if [ -d $HOME/.cabal/bin ]; then
  for bin in $HOME/.cabal/bin; do
    if [ -d $bin ]; then
      export PATH=$bin:$PATH
    fi
  done
fi

case "${OSTYPE}" in
  darwin*)
  # for MacPorts
  if [ -d "/opt/local/bin" ]; then
    export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
    export MANPATH=/opt/local/man:$MANPATH
  fi
esac

if [ -d $HOME/.npm ]; then
  for bin in $HOME/.npm/*/*/package/bin
  do
    export PATH=$bin:$PATH
  done
fi

if [ -d $HOME/local/bin ]; then
  for bin in $HOME/local/bin; do
    if [ -d $bin ]; then
      export PATH=$bin:$PATH
    fi
  done
fi



## Bindkey #{{{1
bindkey '' backward-delete-char
bindkey '' backward-delete-char
bindkey '[3~' backward-delete-char





## Utils {{{1
# up to home in git repository
function gu() {
  local cdup="./`git rev-parse --show-cdup`"
  if [ $# = 1 ]; then
    cdup+=$1
  fi
  cd $cdup
}

# move to home in mercurial repository
function hu() {
  local cdup=`hg root`
  if [ $# = 1 ]; then
    cdup+="/$1"
  fi
  cd $cdup
}

function hg-rm() {
  hg status | while read file
  do
    echo $file | grep '^?' | awk '{print $2}' | xargs hg add
  done
}

function hg-add() {
  hg status | while read file
  do
    echo $file | grep '^?' | awk '{print $2}' | xargs hg add
  done
}

# if mac OS X call screen saver
case "${OSTYPE}" in
  darwin*)
  function slock() {
    open '/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app'
  }
esac

## __END__ #{{{1
# vim: filetype=zsh foldmethod=marker textwidth=78
