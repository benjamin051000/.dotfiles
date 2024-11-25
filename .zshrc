# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle ':completion:*' menu select 
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

##################################################
# Added by me
##################################################

# bindkey -v is more like vi than vim. Here are some vim-like patches:
# (I think this is) from https://vi.stackexchange.com/questions/31671/set-o-vi-in-zsh-backspace-doesnt-delete-non-inserted-characters
bindkey "^?" backward-delete-char  # vim-like backspace instead of vi-like
bindkey "^W" backward-kill-word 
bindkey "^H" backward-delete-char      # Control-h also deletes the previous char
bindkey "^U" backward-kill-line            

zmodload zsh/complist

##############################
# Set paths
##############################
# quartus stuff
if [ -d "$HOME/.intelFPGA_lite/23.1std/quartus/bin/" ]; then
	export PATH="$PATH:$HOME/.intelFPGA_lite/23.1std/quartus/bin/"
	export QSYS_ROOTDIR="/home/benjamin/.intelFPGA_lite/23.1std/quartus/sopc_builder/bin"
fi

# Questa
if [ -d "$HOME/.intelFPGA_lite/23.1std/questa_fse/bin/" ]; then
	export PATH="$PATH:$HOME/.intelFPGA_lite/23.1std/questa_fse/bin/"
	export LM_LICENSE_FILE="/home/benjamin/.intelFPGA_lite/23.1std/LR-182033_License.dat"
	
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
# Aliases
##############################
if command -v eza &> /dev/null; then
    alias l="eza -F"
    alias ls="eza -F"
    alias ll="eza -laF --git --group --header"
	alias llr="ll --time-style relative"
    alias t="eza -Tl --level 5 --no-user --git --header -F --git-ignore"

else
    alias ls="ls --color=auto"
    alias l="ls -F"
    alias ll="ls -lah"
    alias t=tree
fi

# Follow copied and moved files to destination directory
# From https://unix.stackexchange.com/questions/49802/follow-a-moved-file-to-its-destination-directory
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }
cpf() { cp "$@" && goto "$_"; }
mvf() { mv "$@" && goto "$_"; }

# zsh has .. builtin!
# alias ..="cd .."
alias ...="cd ../.."

# Fedora dnf
if command -v dnf &> /dev/null; then
    alias dnfi="sudo dnf install"
    alias dnfc="sudo dnf check-update"
    alias dnfu="sudo dnf update"
	alias update="dnfc && dnfu"
elif command -v zypper &> /dev/null; then
	alias update="sudo zypper refresh && sudo zypper dist-upgrade"
fi


# (neo)vim aliases
# these are set up in a redundant manner, where
# v will always work even if you only have vi 
# or vim installed
if command -v nvim &> /dev/null; then
    alias vim=nvim
fi
alias vi=vim
alias v=vi


# git
alias g="git"
# alias gs="git status"
# alias ga="git add"
# alias gsw="git switch"
# alias glog="git log"
# alias gcl="git clone"
# alias gcm="git commit"
alias gpush="git push"
alias gpull="git pull"
# alias gdiff="git difftool --no-symlinks --dir-diff"
# alias gd=gdiff
  
# Starship prompt
eval "$(starship init zsh)"


# open files in default app
alias open=xdg-open

# weather :)
alias weather='curl wttr.in'

if command -v fzf &> /dev/null; then
	# Check if the version is high enough to support this method.
	# I need this because currently debian/ubuntu doesn't have v0.48
	# which supports the --zsh flag.
	if fzf --zsh &> /dev/null; then
		# Set up fzf key bindings and fuzzy completion
		source <(fzf --zsh)
	else
		source /usr/share/doc/fzf/examples/key-bindings.zsh 
		source /usr/share/doc/fzf/examples/completion.zsh
	fi
else
	# Reverse search history via C-r
    bindkey '^R' history-incremental-search-backward
fi

if command -v rg &> /dev/null; then
    alias grep=rg
fi

if command -v bat &> /dev/null; then
    alias cat=bat
fi

alias tm="tmux"

alias py="python3.12"

# thefuck
if command -v thefuck &> /dev/null; then
    eval $(thefuck --alias)
fi

if command -v cbonsai &> /dev/null; then
    alias bonsai="cbonsai --life 40 --multiplier 5 --time 20 --screensaver"
fi

if command -v pv &> /dev/null; then
	rmpv() {
		rm -rv "$1" | pv -l -s $(du -a "$1" | wc -l) > /dev/null
	}
fi

# Clipboard
alias clip="xclip -selection c"

##############################
# Edit zsh buffer in vim
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

if ! command -v reboot &> /dev/null; then
	alias reboot="systemctl reboot"
	alias restart="reboot"
fi


# Kitty
alias icat="kitty +kitten icat"
alias img=icat
alias pic=icat
alias diff="kitty +kitten diff"
alias kssh="kitty +kitten ssh"

# Fun prompt
if command -v pokemon-colorscripts &> /dev/null; then
	pokemon-colorscripts --random
fi 

zsh_syntax_highlighting_path="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f "$zsh_syntax_highlighting_path" ]; then
	source "$zsh_syntax_highlighting_path"
fi

# OSS CAD Suite, TODO install this properly
# oss_cad_path="$HOME/Downloads/oss-cad-suite/environment"
# if [ -f "$oss_cad_path"	]; then
# 	source "$oss_cad_path"
# fi


# Reboot directly to Windows
# Inspired by http://askubuntu.com/questions/18170/how-to-reboot-into-windows-from-ubuntu
windows() {
	# Set the next grub boot via grub2-reboot. See manpage for info.
    sudo grub2-reboot "Windows Boot Manager (on /dev/nvme0n1p1)" && sudo reboot
}

autoload bashcompinit
bashcompinit
source "$HOME/.workrc"

. "$HOME/.cargo/env"
