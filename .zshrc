[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory HIST_IGNORE_DUPS HIST_IGNORE_SPACE AUTO_CD EXTENDED_GLOB MULTIOS CORRECT nohup auto_resume nomatch notify
unsetopt beep

autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*:processes-names' command 'ps -e -o comm='
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'


autoload -U promptinit
promptinit
prompt adam2 8bit `uname -ni | sha1sum | cut -c 3` 14 7

# key bindings
bindkey -e
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

alias ls='ls -Gh --color'
alias l='ls -lGh --color'
alias ll='ls -lath --color'
alias grep='grep --color'
alias ungz='tar xvzf'
alias unbz='tar xvjf'
alias @='sudo '
alias ta='textadept-curses'
alias s='subl3 -n --command toggle_menu'
alias s.='subl3 -n --command toggle_menu -a . README*(N)'

[[ -x /usr/bin/keychain ]] && eval $(keychain --eval --agents ssh -Q --quiet id_ecdsa id_rsa)

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev/web
export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
[[ -x /usr/bin/virtualenvwrapper_lazy.sh ]] && source /usr/bin/virtualenvwrapper_lazy.sh

[[ -x /usr/bin/dircolors ]] && [[ -e .dircolors ]] && eval `dircolors .dircolors`

[[ -x ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#PATH=$PATH:$HOME/.gem/ruby/2.1.0/bin

PATH=$HOME/.cabal/bin:$PATH

PATH=$PATH:/opt/clean/bin

# OPAM configuration
. /home/ssdd/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# nix
. /home/ssdd/.nix-profile/etc/profile.d/nix.sh
