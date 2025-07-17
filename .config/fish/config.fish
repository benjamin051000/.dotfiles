if status is-interactive
    # Commands to run in interactive sessions can go here
end


abbr --add g git
export GIT_EDITOR=nvim

# eza (ls)
if type --query eza 
	alias ls="eza --classify=auto"
	abbr --add l ls
	alias ll="ls --long"
	alias tree="ls --tree --level 5 --no-user --header"
	abbr --add t tree
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
end

# fzf fuzzy-finder
if type --query fzf
	if fzf --fish &> /dev/null
		fzf --fish | source
	else
		source /usr/share/doc/fzf/examples/key-bindings.fish
		source /usr/share/doc/fzf/examples/completion.fish
	end
end

# Rust tools
# ripgrep
if type --query rg 
	abbr --add grep rg
end

# bat
if type --query bat 
	abbr --add cat bat --pager less
end

abbr --add py python

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
