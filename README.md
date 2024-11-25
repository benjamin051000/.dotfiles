# .dotfiles
These are my environment files for my computer.

# Dependencies
- [GNU stow](https://www.gnu.org/software/stow/)
- [Kitty](https://sw.kovidgoyal.net/kitty/) (terminal emulator)
- [Neovim](https://neovim.io/) (text editor)
  - [Packer](https://github.com/wbthomason/packer.nvim#quickstart)
- [zsh](https://www.zsh.org/) (shell)
    - [fzf](https://junegunn.github.io/fzf/)
- [tmux](https://github.com/tmux/tmux)

# Installation
```bash
# Clone the repository.
cd ~
git clone --recurse-submodules git@github.com:benjamin051000/.dotfiles.git 
cd .dotfiles/
# Use GNU stow to apply dotfiles.
stow --dotfiles ~/.dotfiles/
# Optionally, use --adopt to bring in new changes added before cloning.
stow --adopt ~/.dotfiles/

# Use git like normal.
cd ~/.dotfiles/
git status
```

---
# Dotfiles best practices
## zsh startup files tips
- if it is needed by a command run non-interactively: `.zshenv`
- if it should be updated on each new shell: `.zshenv`
- if it runs a command which may take some time to complete: `.zprofile`
- if it is related to interactive usage: `.zshrc`
- if it is a command to be run when the shell is fully setup: `.zlogin`
- if it releases a resource acquired at login: `.zlogout`

