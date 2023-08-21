# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Added by me

# Basic auto/tab complete:
zstyle ':completion:*' menu select
zmodload zsh/complist

# Aliases
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

alias py=python3
# zsh has .. builtin!
alias ...="cd ../.."

# Fedora dnf
alias dnfi="sudo dnf install"
alias dnfc="sudo dnf check-update"
alias dnfu="sudo dnf update"

# neovim
alias vim=nvim
alias vi=vim
alias v=vi

# git
# alias g=git
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
alias grep=rg
alias cat=bat

# Reverse search history via C-r
bindkey '^R' history-incremental-search-backward

# Clipboard
alias clip="xclip -selection c"

# Edit buffer in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Set editors to neovim
GIT_EDITOR=nvim
VISUAL=nvim
EDITOR=nvim
export GIT_EDITOR VISUAL EDITOR

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
eval $(thefuck --alias)

# open files in default app
alias open=xdg-open

# weather :)
alias weather='curl wttr.in'

# set PATH so it includes user's private ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add quartus to the path because why not 
if [ -d "$HOME/.intelFPGA/20.1/quartus/bin" ]; then
    export PATH="$HOME/.intelFPGA/20.1/quartus/bin:$PATH"
fi

if [ -d "$HOME/intelFPGA/20.1/quartus/bin" ]; then
    export PATH="$HOME/intelFPGA/20.1/quartus/bin:$PATH"
fi

if [ -d "/home/benjamin/intelFPGA_lite/21.1/questa_fse/bin/" ]; then
    export LM_LICENSE_FILE="/home/benjamin/intelFPGA_lite/LR-090178_License.dat" 
    export PATH="$HOME/intelFPGA_lite/21.1/questa_fse/bin/:$PATH"
fi


if [ -d "$HOME/.spicetify" ]; then
    export PATH=$PATH:$HOME/.spicetify
fi


