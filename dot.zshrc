# .zshrc

# load antigen settings
source ~/.zsh/_antigen

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

# Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=4294967295
SAVEHIST=4294967295


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

PROMPT="${git_status}%{$reset_color%} < "
RPROMPT="[${current_dir}${git_info}]"

## Aliases #{{{1
case "${OSTYPE}" in
  darwin*)
    alias ls="ls -G -w -F"
    alias firefox="open -a Firefox"
    alias preview="open -a Preview"
    alias safari="open -a Safari"
    alias cot="open -a CotEditor"
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
esac

alias grep="grep -n --color=auto"
alias la="ls -a"
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

# for tmux
alias t="tmux"
alias ta="tmux -2 attach -dt"
alias tn="tmux -2 new -s"

# for git
alias g="git"
alias a="git add"
alias b="git branch"
alias c="git commit"
alias d="git diff"
alias ge="git config -e"
alias f="git fetch"
alias gg="git grep -n"
alias l="git log --pretty=oneline2"
alias gp="git push"
alias gsw="git show"
alias gvn="git svn"
alias gsh="git stash"
alias gshp="git stash pop"
alias s="git status -sb"

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
  export PATH=/usr/local/bin:$PATH
fi

# for haskell application
if [ -d $HOME/.cabal/bin ]; then
  export PATH=$HOME/.cabal/bin:$PATH
fi

case "${OSTYPE}" in
  darwin*)
  # for MacPorts
  if [ -d "/opt/local/bin" ]; then
    export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
    export MANPATH=/opt/local/man:$MANPATH
  fi
  if [ -d /usr/local/share/npm/bin ]; then
    export PATH=/usr/local/share/npm/bin:$PATH
  fi
esac

# Shared Library Path
if [ -d /usr/local/lib ]; then
  export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
fi

if [ -d /usr/local/share/npm/lib/node_modules ]; then
  export NODE_PATH=/usr/local/share/npm/lib/node_modules:$NODE_PATH
fi

if [ -f ~/.aws.conf ]; then
  source ~/.aws.conf
fi

if [ -d $HOME/.rbenv ]; then
  export PATH=$HOME/.rbenv/shims:$PATH
fi

if [ -d $HOME/local/bin ]; then
  export PATH=$HOME/local/bin:$PATH
fi

if [ -d $HOME/bin ]; then
  export PATH=$HOME/bin:$PATH
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

## __END__ #{{{1
# vim: filetype=zsh foldmethod=marker textwidth=78
