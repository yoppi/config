# .zshrc

# misc. #{{{1
# Environment variable configuration 
export LANG=ja_JP.UTF-8

# Keybind configuration
#   * -e: emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes to end of it)
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
function prompt_setup() {
  local c_reset=$'\e[0m'
  local c_cyan=$'\e[36m'
  local c_green=$'\e[32m'
  local c_red=$'\e[31m'
  local c_yellow=$'\e[33m'

  local c_host="$c_green"
  local c_user
  case "$USER" in
    root)
      c_user="$c_red"
      ;;
    *)
      c_user="$c_green"
      ;;
  esac
  
  local t_host="$c_user%n$c_reset$c_host@%m$c_reset"
  local t_cwd="$c_cyan%~$c_reset"
  #local t_main="%m%(!.#.>) "
  local t_main="/ _ /X %(!.#.<) "
  PS1="$t_host $t_cwd
$t_main"
}

prompt_setup
unset -f prompt_setup





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
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;35:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
      'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

## set terminal title including current directory
case "${TERM}" in
kterm*|xterm*|screen)
  precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=fxfxcxdxbxegedabagacad
  export LS_COLORS='di=35:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
      'di=35' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac





## PATH #{{{1
case "${OSTYPE}" in
  darwin*)
  if [ -d "/opt/local/bin/" ]; then
    export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
    export MANPATH=/opt/local/man:$MANPATH
  fi
  if [ -d "${HOME}/bin/" ]; then
    export PATH=${HOME}/bin:$PATH
  fi
  ## for NS2
  #export PATH=/Users/yoshida/bin/ns2/bin:/Users/yoshida/bin/ns2/tcl8.4.18/unix:/Users/yoshida/bin/ns2/tk8.4.18/unix:/Users/yoshida/bin/ns2/otcl:$PATH
  #export LD_LIBRARY_PATH=/Users/yoshida/bin/ns2/otcl-1.13:/Users/yoshida/bin/ns2/lib:$LD_LIBRARY_PATH
  #export TCL_LIBRARY=/Users/yoshida/bin/ns2/tcl8.4.18/library:$TCL_LIBRARY
  ;;
  linux*)
  if [ -d "${HOME}/bin/screen/" ]; then
    export PATH=${HOME}/bin/screen/bin:$PATH
  fi
  if [ -d "${HOME}/bin/vim/" ]; then
    export PATH=${HOME}/bin/vim/bin:$PATH
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
  export http_proxy=http://cache.is.oit.ac.jp:8080
  ;;
esac

## for NuSMV
#export NuSMV_LIBRARY_PATH=/Users/yoshida/bin/nusmv/share

## set SVN_EDITOR
export SVN_EDITOR=vim





## Bindkey #{{{1
#bindkey '^?'    backward-delete-char
#bindkey '^H'    backward-delete-char
#bindkey '^[[3~' backward-delete-char
bindkey '' backward-delete-char
bindkey '' backward-delete-char
bindkey '[3~' backward-delete-char



## Screen #{{{1
#if [ "$TERM" = "screen" ]; then
#  #"chpwd () { echo -n "_`dirs`\\" }
#  preexec() {
#    emulate -L zsh
#      local -a cmd; cmd=(${(z)2})
#      case $cmd[1] in
#        fg)
#          if (( $#cmd == 1 )); then
#            cmd=(builtin jobs -l %+)
#          else
#            cmd=(builtin jobs -l $cmd[2])
#          fi
#          ;;
#        %*) 
#          cmd=(builtin jobs -l $cmd[1])
#          ;;
#        cd)
#          if (( $#cmd == 2)); then
#            cmd[1]=$cmd[2]
#          fi
#          ;&
#        *)
#          echo -n "k$cmd[1]:t\\"
#          return
#          ;;
#      esac
#      local -A jt; jt=(${(kv)jobtexts})
#      $cmd >>(read num rest
#      cmd=(${(z)${(e):-\$jt$num}})
#      echo -n "k$cmd[1]:t\\") 2> /dev/null
#  }
#  #chpwd
#fi

#autoload colors
#colors
#case ${UID} in
#0)
#    PROMPT="%B%{${fg[green]}%}%/#%{${reset_color}%}%b "
#    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
#    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#    ;;
#*)
#    PROMPT="%{${fg[cyan]}%}%/%{${reset_color}%}
#%{${fg[green]}%}[%m@${TERM}]%{${reset_color}%}%% "
#    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
#    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#    RPROMPT="%{${fg[yellow]}%}[%*]%{${reset_color}%}"
#    ;;
#esac

#case "${OSTYPE}" in
#darwin*)
#    alias updateports="sudo port selfupdate; sudo port outdated"
#    alias portupgrade="sudo port upgrade installed"
#    ;;
#freebsd*)
#    case ${UID} in
#    0)
#        updateports() 
#        {
#            if [ -f /usr/ports/.portsnap.INDEX ]
#            then
#                portsnap fetch update
#            else
#                portsnap fetch extract update
#            fi
#            (cd /usr/ports/; make index)
#
#            portversion -v -l \<
#        }
#        alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
#        ;;
#    esac
#    ;;
#esac

## Prediction configuration
#
#autoload predict-on
#predict-off


## Utils {{{1

## __END__ #{{{1
# vim: filetype=zsh foldmethod=marker
