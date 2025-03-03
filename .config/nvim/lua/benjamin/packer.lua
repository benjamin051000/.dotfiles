-- Packer plugin manager

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use "wbthomason/packer.nvim"

	-- Simple plugins can be specified as strings
	use "folke/tokyonight.nvim"

	--use 'junegunn/fzf'

	use {
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8", -- or, branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	}

	-- Allows for easier switching out of vim into tmux panes
	use "christoomey/vim-tmux-navigator"

	-- Treesitter (for syntax highlighting/indentation)
	-- nvim has this built-in, but this plugin allows
	-- for easier config
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}

	use "nvim-treesitter/nvim-treesitter-context"      -- Sticky headers

	use "windwp/nvim-autopairs"                        -- Auto pair closing () [] {} "" etc

	use "neovim/nvim-lspconfig"                        -- Configurations for Nvim LSP
	use "williamboman/mason.nvim"                      -- Auto-install LSPs
	use "https://git.sr.ht/~whynothugo/lsp_lines.nvim" -- lsp lines

	-- vim surround
	use { "kylechui/nvim-surround", tag = "*" } -- Use for stability; omit to use `main` branch for the latest features

	use "numToStr/Comment.nvim"                 -- auto comment

	use {
		"abecodes/tabout.nvim",
		wants = { "nvim-treesitter" }, -- or require if not used so far
		-- after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
	}

	-- nvim-cmp autocompletion
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "hrsh7th/nvim-cmp"
	-- luasnip, bc some dude on discord
	-- said to install these too
	use "L3MON4D3/LuaSnip"
	use "saadparwaiz1/cmp_luasnip"

	use "tpope/vim-fugitive"

	-- tabnine
	-- use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

	-- a fun one
	use "eandrju/cellular-automaton.nvim"

	use {
		'folke/trouble.nvim',
		tag = 'v2.2.2',
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require "trouble".setup {}
		end
	}

	-- use 'jose-elias-alvarez/null-ls.nvim'
end)
