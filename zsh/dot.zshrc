# .zshrc

# misc. #{{{1
# Environment variable configuration 
export LANG=ja_JP.UTF-8

# Keybind configuration
#   * -e: emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e
#   goes to end of it)
#   * -v: vi like keybind. modal key editing.
#bindkey -e
bindkey -v

# Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# zsh editor
autoload zed

# load user .zshrc configuration file
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

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
setopt promptsubst

# Load the prompt theme system
autoload -U promptinit
promptinit

# Use the wunjo prompt theme
prompt yoppi




## Aliases #{{{1
case "${OSTYPE}" in
  darwin*)
    alias ls="ls -G -w"
    alias firefox="open -a Firefox"
    alias preview="open -a Preview"
    alias safari="open -a Safari"
    alias cot="open -a CotEditor"
    ;;
  linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias lt="ls -lt"
alias lth="ls -lt | head"
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias where="command -v"
alias j="jobs -l"
alias v="vim"



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
case "${OSTYPE}" in
  darwin*)
  # for MacPorts
  if [ -d "/opt/local/bin" ]; then
    export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
    export MANPATH=/opt/local/man:$MANPATH
  fi
  if [ -d "$HOME/local/" ]; then
    for app in "$HOME/local/"
    export PATH=$HOME/bin:$PATH
  fi
  ;;
  linux*)
  # HOME/local/, /usr/local/apps/のアプリケーション毎のbinを$PATHに追加したい
  if [ -d "${HOME}/bin/screen/" ]; then
    export PATH=$HOME/bin/screen/bin:$PATH
  fi
  if [ -d "${HOME}/bin/vim/" ]; then
    export PATH=$HOME/bin/vim/bin:$PATH
  fi
  if [ -d "/usr/local/apps/ruby1.8.7/" ]; then
    export PATH=/usr/local/apps/ruby1.8.7/bin:$PATH
  fi
  if [ -d "/usr/local/apps/rubygems1.3.1/" ]; then
    export PATH=/usr/local/apps/rubygems1.3.1/bin:$PATH
    if [ -d "/usr/local/apps/gemrepos/" ]; then
      export PATH=/usr/local/apps/gemrepos/bin:$PATH
      export GEM_HOME=/usr/local/apps/gemrepos
      export RUBYLIB=/usr/local/apps/rubygems1.3.1/lib:$RUBYLIB
    fi
  fi
  if [ -d "/usr/local/apps/jdk1.6.0_11/" ]; then
    export PATH=/usr/local/apps/jdk1.6.0_11/bin:$PATH
  fi
  if [ -d "/usr/local/apps/git1.6/" ]; then
    export PATH=/usr/local/apps/git1.6/bin:$PATH
  fi
  if [ -d "/usr/local/apps/vim72/" ]; then
    export PATH=/usr/local/apps/vim72/bin:$PATH
  fi
  if [ -d "/usr/local/apps/mecab/" ]; then
    export PATH=/usr/local/apps/mecab/bin:$PATH
  fi
  ;;
esac

## set SVN_EDITOR
export SVN_EDITOR=vim




## Bindkey #{{{1
bindkey '' backward-delete-char
bindkey '' backward-delete-char
bindkey '[3~' backward-delete-char






## Utils {{{1

## __END__ #{{{1
# vim: filetype=zsh foldmethod=marker textwidth=78
