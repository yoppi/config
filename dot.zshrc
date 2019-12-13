# Prologue #{{{1

# load antigen
[ -f ~/.zsh/_antigen ] && source ~/.zsh/_antigen
# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey -e
#bindkey -v
bindkey '' backward-delete-char
bindkey '' backward-delete-char
bindkey '[3~' backward-delete-char

# completion
autoload -U compinit && compinit

# zsh editor
autoload -U zed

# parameters
HISTFILE=~/.zsh_history
HISTSIZE=4294967295
SAVEHIST=4294967295

# Environments#{{{1
export LANG=ja_JP.UTF-8
export SVN_EDITOR=vim

case ${OSTYPE} in
  darwin*)
    export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
    ;;
  *)
    export EDITOR=vim
    ;;
esac

## for fakeclip.vim
case $OSTYPE in
  darwin*)
    export __CF_USER_TEXT_ENCODING=0x1F5:0x08000100:0
  ;;
esac

## PATH
if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
fi

if [ -d /usr/local/opt/python/libexec/bin ]; then
  export PATH=/usr/local/opt/python/libexec/bin:$PATH
fi

if [ -d $HOME/.cabal/bin ]; then
  export PATH=$HOME/.cabal/bin:$PATH
fi

if [ -d $HOME/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
  eval "$(rbenv init -)"
fi

if [ -d $HOME/.pyenv ]; then
  export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
  eval "$(pyenv init -)"
fi

if [ -d $HOME/local/go/1.13.5 ]; then
  export GOPATH=$HOME
  export GOROOT=$HOME/local/go/1.13.5
fi

if [ -d $HOME/local/bin ]; then
  export PATH=$HOME/local/bin:$PATH
fi

if [ -d $HOME/bin ]; then
  export PATH=$HOME/bin:$PATH
fi

if [ -d /usr/local/lib ]; then
  export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
fi

# Options #{{{1
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

# Prompt #{{{1
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=":%{$FG[033]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_DIRTY=""
#ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"
ZSH_THEME_GIT_PROMPT_CLEAN=""

local git_status='$(git_prompt_status)'
ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[046]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[202]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[124]%}x"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[201]%}@"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[190]%}="
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[190]%}?"

local current_dir='${PWD/#$HOME/~}'

PROMPT="${git_status}%{$reset_color%}$ "
RPROMPT="[${current_dir}${git_info}]"

# Aliases #{{{1
case "${OSTYPE}" in
  darwin*)
    alias ls="ls -G -w -F"
    alias gvim="/Applications/MacVim.app/Contents/MacOS/Vim -g"
    alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
    ;;
  linux*)
    alias ls="ls --color --file-type"
    alias open="xdg-open"
    ;;
  cygwin*)
    alias ls="ls --color --file-type"
    alias open="cygstart"
    ;;
esac

alias grep="grep -n --color=auto"
alias la="ls -a"
alias ll="ls -l"
alias lt="ls -lt"
alias ltr="ls -altr"
alias where="command -v"
alias v="vim"
alias r="rails"

# for tmux
alias t="tmux"
alias ta="tmux -2 attach -dt"
alias tn="tmux -2 new -s"

# for git
alias g="git"
alias a="git add"
alias b="git branch"
alias d="git diff"
alias f="git fetch"
alias gg="git grep -n"
alias l="git log --pretty=oneline2"
alias s="git status -sb"

# for secure!
alias cp="cp -i"
alias mv="mv -i"

# Search #{{{1
# historical backward/forward search with linehead string binded to ^P/^N
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# Colors #{{{1
zstyle ':completion:*' list-colors ''

# Functions {{{1
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

function fzf-z-search() {
  local res=$(z | sort -rn | cut -c 12- | fzf)
  if [ -n "${res}" ]; then
    BUFFER+="cd ${res}"
    zle accept-line
  else
    return 1
  fi
}

zle -N fzf-z-search
bindkey "^g" fzf-z-search

# if mac OS X call screen saver
case "${OSTYPE}" in
  darwin*)
  function slock() {
    open '/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app'
  }
  if [ `brew --prefix`/etc/profile.d/z.sh ]; then
    . `brew --prefix`/etc/profile.d/z.sh
    if ! [ -f $HOME/.z ]; then
      touch $HOME/.z
    fi
    function precmd() {
      _z --add "$(pwd -P)"
    }
  fi
esac

# __END__ #{{{1
# vim: filetype=zsh foldmethod=marker textwidth=78
