# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
## I use starship so comment this out
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


##################################################
# End of oh-my-zsh
##################################################

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
    # echo "Can't find ~/utils dir. Skipping"
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
    export FZF_ALT_C_OPTS="--preview 'eza --tree {}'"
fi

# Reverse search history via C-r
if [ ! $(command -v fzf) ]; then
    bindkey '^R' history-incremental-search-backward
fi

##############################
# Aliases
##############################
if [ $(command -v 'eza') ]; then
    alias l="eza -F"
    alias ls="eza -F"
    alias ll="eza -laF --no-user --git --header"
    alias t="eza -Tl --level 5 --no-user --git --header"

else
    echo "eza not installed! Using tree instead"
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

# quartus stuff
export QSYS_ROOTDIR="/home/benjamin/.intelFPGA_lite/23.1std/quartus/sopc_builder/bin"
export LM_LICENSE_FILE='.intelFPGA_lite/23.1std/LR-162888_License.dat'
# add it to the path
export PATH="$PATH:/home/benjamin/.intelFPGA_lite/23.1std/quartus/bin/"
export PATH="$PATH:/home/benjamin/.intelFPGA_lite/23.1std/questa_fse/bin/"
