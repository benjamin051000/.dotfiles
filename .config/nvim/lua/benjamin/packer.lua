-- Packer plugin manager

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Simple plugins can be specified as strings
    use 'folke/tokyonight.nvim'

    --use 'junegunn/fzf'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0', -- or, branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Allows for easier switching out of vim into tmux panes
    use 'christoomey/vim-tmux-navigator'

    -- Treesitter (for syntax highlighting/indentation)
    -- nvim has this built-in, but this plugin allows
    -- for easier config
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'nvim-treesitter/nvim-treesitter-context' -- Sticky headers

    use "windwp/nvim-autopairs" -- Auto pair closing () [] {} "" etc

    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP

    use "williamboman/mason.nvim" -- Auto-install LSPs

    -- vim surround 
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    })

    use "https://git.sr.ht/~whynothugo/lsp_lines.nvim" -- lsp lines

    use 'numToStr/Comment.nvim' -- auto comment

    use 'simrat39/rust-tools.nvim' -- auto-install rust LSP stuff because apparently it's not easy

    use {
      'abecodes/tabout.nvim',
        wants = {'nvim-treesitter'}, -- or require if not used so far
        -- after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
    }

end)

