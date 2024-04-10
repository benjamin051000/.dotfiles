# .dotfiles
These are my environment files for my computer.

# Installation
```bash
# Clone the repository.
cd ~
gh repo clone .dotfiles --recurse-submodules
cd .dotfiles
# Use GNU stow to apply dotfiles.
stow .
# Optionally, use --adopt to bring in new changes.
stow --adopt .

# Use git like normal.
cd .dotfiles 
git status
```

## Requirements
- Kitty (terminal emulator)
- Neovim (text editor)
  - [Packer](https://github.com/wbthomason/packer.nvim#quickstart)
- zsh (shell)
    - fzf
- tmux


## zsh Cheatsheet:
- if it is needed by a command run non-interactively: .zshenv
- if it should be updated on each new shell: .zshenv
- if it runs a command which may take some time to complete: .zprofile
- if it is related to interactive usage: .zshrc
- if it is a command to be run when the shell is fully setup: .zlogin
- if it releases a resource acquired at login: .zlogout

