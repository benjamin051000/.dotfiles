# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/benjamin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Added by me

# Basic auto/tab complete:
zstyle ':completion:*' menu select
zmodload zsh/complist

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/benjamin/.anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/benjamin/.anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/benjamin/.anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/benjamin/.anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Aliases
alias ls="ls --color=auto"
alias l="ls -F"
alias ll="ls -lah"
alias t=tree

alias py=python3
# zsh has .. builtin!
alias ...="cd ../.."

# Fedora dnf
alias dnfi="sudo dnf install"
alias dnfc="dnf check-update"
alias dnfu="sudo dnf update"

# neovim
alias vim=nvim
alias vi=vim
alias v=vi

# git
alias gs="git status"
alias ga="git add"
alias gcl="git clone"
alias gcm="git commit -m"
alias gpush="git push"
alias gd="git difftool --no-symlinks --dir-diff"  # Uses Kitty diff tool

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
alias diff="kitty +kitten diff"

# Manage dotfiles bare git repo
alias dotfiles="$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Starship prompt
eval "$(starship init zsh)"

