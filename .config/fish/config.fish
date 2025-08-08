if status is-interactive
    # Commands to run in interactive sessions can go here
end


abbr --add g git

# eza (ls)
if type --query eza 
	alias ls="eza --classify=auto"
	abbr --add l ls
	alias ll="ls --long"
	alias lla="ls --long --all"
	alias tree="ls --tree --level 5 --no-user --header"
	abbr --add t tree
	alias llr="ll --time-style relative --sort old"
	
end

# multicd
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

if type --query nvim
	abbr --add v nvim
	# nvim as the pager
	export MANPAGER="nvim +Man!"
	export GIT_EDITOR=nvim
else if type --query nvim-linux-x86_64.appimage
	alias nvim=nvim-linux-x86_64.appimage
	abbr --add v nvim
	export GIT_EDITOR=nvim-linux-x86_64.appimage
end

# fzf fuzzy-finder
if type --query fzf
	if fzf --fish &> /dev/null
		fzf --fish | source
	else
		source /usr/share/doc/fzf/examples/key-bindings.fish
	end
end

# Rust tools
# ripgrep
if type --query rg 
	abbr --add grep rg
end

# bat
if type --query bat 
	alias cat="bat --pager less"
end

abbr --add py python
abbr --add python python3

# Add ~/.local/bin to PATH
fish_add_path ~/.local/bin/

function fish_greeting 
	if type --query pokemon-colorscripts
		set shiny_chance 30
		if test (random 1 $shiny_chance) -eq $shiny_chance
			set --function shiny --shiny
		else
			set --function shiny
		end
		pokemon-colorscripts --random $shiny
	end
end

# Reboot directly to Windows
# Inspired by http://askubuntu.com/questions/18170/how-to-reboot-into-windows-from-ubuntu
# function windows
# 	# Set the next grub boot via grub2-reboot. See manpage for info.
#     sudo grub2-reboot "Windows Boot Manager (on /dev/nvme0n1p1)" && sudo reboot
# end

function fix_powerdevil
	# These don't seem to work
	# local temp=$(ddcutil getvcp --brief 10 | awk '{print $4;}')
	systemctl --user restart plasma-powerdevil.service
	# ddcutil setvcp 10 $temp
end
