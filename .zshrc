# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

##################################################
# Added by me
##################################################

# TODO did I add this manually?
# Basic auto/tab complete:
zstyle ':completion:*' menu select  # TODO does this override above similarl line?
zmodload zsh/complist

##############################
# Get SOC DV stuff set up
##############################
# WARNING this file clobbers LD_LIBRARY_PATH! It's not my fault.
[ -e .socdvrc ] && source .socdvrc

##############################
# Set paths
##############################
# ~/.local directory
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.intelFPGA/20.1/quartus/bin" ]; then
    export PATH="$HOME/.intelFPGA/20.1/quartus/bin:$PATH"
fi

if [ -d "$HOME/intelFPGA/20.1/quartus/bin" ]; then
    export PATH="$HOME/intelFPGA/20.1/quartus/bin:$PATH"
fi

if [ -d "$HOME/intelFPGA_lite/21.1/questa_fse/bin/" ]; then
    export LM_LICENSE_FILE="$HOME/intelFPGA_lite/LR-090178_License.dat" 
    export PATH="$HOME/intelFPGA_lite/21.1/questa_fse/bin/:$PATH"
fi

if [ -d "$HOME/.spicetify" ]; then
    export PATH=$PATH:$HOME/.spicetify
fi

# ~/utils directory
if [ -d "$HOME/utils" ] ; then
    UTILS="$HOME/utils"

    export PATH="$UTILS/bin:$PATH"
    export MANPATH="$UTILS/share:$MANPATH"

    # Set up C libraries and whatnot
    export C_INCLUDE_PATH="$UTILS/include:$C_INCLUDE_PATH"
    export CPLUS_INCLUDE_PATH="$UTILS/include:$CPLUS_INCLUDE_PATH"

    export LIBRARY_PATH="$UTILS/lib:$LIBRARY_PATH"
    export LD_LIBRARY_PATH="$UTILS/lib:$LD_LIBRARY_PATH"

    unset UTILS
else
    echo "Can't find ~/utils dir. Skipping"
fi

##############################
# Set up fzf
##############################
# TODO how does this change if it's installed via package manager?
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
if [ $(command -v fd) ] && [ $(command -v fzf) ]; then
    # Use fd instead of gnu find
    export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude .git --exclude .SYNC"
    export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"

    export FZF_ALT_C_COMMMAND="$FZF_CTRL_T_COMMAND --type directory"
    export FZF_ALT_C_OPTS="--preview 'exa --tree {}'"
fi

# Reverse search history via C-r
if [ ! $(command -v fzf) ]; then
    bindkey '^R' history-incremental-search-backward
fi

##############################
# Aliases
##############################
if [ $(command -v 'exa') ]; then
    alias l="exa -F"
    alias ls="exa -F"
    alias ll="exa -laF --no-user --git --header"
    alias t="exa -Tl --level 5 --no-user --git --header"

else
    echo "exa not installed! Using tree instead"
    alias ls="ls --color=auto"
    alias l="ls -F"
    alias ll="ls -lah"
    alias t=tree
fi

# From https://unix.stackexchange.com/questions/49802/follow-a-moved-file-to-its-destination-directory
# Follow copied and moved files to destination directory
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }
cpf() { cp "$@" && goto "$_"; }
mvf() { mv "$@" && goto "$_"; }

# zsh has .. builtin!
# alias ..="cd .."
alias ...="cd ../.."

# Fedora dnf
if [ $(command -v dnf) ]; then
    alias dnfi="sudo dnf install"
    alias dnfc="sudo dnf check-update"
    alias dnfu="sudo dnf update"
fi

# (neo)vim aliases
# these are set up in a redundant manner, where
# v will always work even if you only have vi 
# or vim installed
if [ $(command -v nvim) ]; then
    alias vim=nvim
fi
alias vi=vim
alias v=vi


# git
alias gs="git status"
alias ga="git add"
alias gsw="git switch"
alias glog="git log"
alias gcl="git clone"
alias gcm="git commit"
alias gpush="git push"
alias gpull="git pull"
alias gdiff="git difftool --no-symlinks --dir-diff"
alias gd=gdiff
  
# Misc. tools
if [ $(command -v rg) ]; then
    alias grep=rg
fi

if [ $(command -v bat) ]; then
    alias cat=bat
fi

alias tm=tmux

alias c=clear

alias py=python3

# Clipboard
alias clip="xclip -selection c"

##############################
# Edit buffer in vim
##############################
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

##############################
# Set editors to neovim
##############################
# TODO what if it isn't installed? can I use the `v` alias?
GIT_EDITOR=nvim
VISUAL=nvim
EDITOR=nvim
export GIT_EDITOR VISUAL EDITOR


##############################
# Other
##############################
# Kitty
alias icat="kitty +kitten icat"
alias img=icat
alias pic=icat
alias diff="kitty +kitten diff"
alias kssh="kitty +kitten ssh"

# Manage dotfiles bare git repo
alias dotfiles="$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Starship prompt
eval "$(starship init zsh)"

# thefuck
if [ $(command -v thefuck) ]; then
    eval $(thefuck --alias)
fi

# open files in default app
alias open=xdg-open

# weather :)
alias weather='curl wttr.in'
