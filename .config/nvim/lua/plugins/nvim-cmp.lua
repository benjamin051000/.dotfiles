return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		-- "onsails/lspkind.nvim", -- pictograms for completion items
		"L3MON4D3/LuaSnip", -- expand LSP snippets
		"saadparwaiz1/cmp_luasnip", -- source for LuaSnip
		-- "sar/friendly-snippets", -- misc. lang-specific snippets
		"windwp/nvim-autopairs", -- for extra configuration (see below)
		"hrsh7th/cmp-nvim-lsp"  -- for LSPs. Required for nvim 0.11? 
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		-- local lspkind = require("lspkind")

		-- load vscode-like snippets from plugins (e.g., friendly-snippets)
		-- require("luasnip.loaders.from_vscode").lazy_load()

		vim.opt.completeopt = "menu,menuone,noselect"
		
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end
			},
			mapping = cmp.mapping.preset.insert({
			  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
			  ['<C-f>'] = cmp.mapping.scroll_docs(4),
			  ['<C-Space>'] = cmp.mapping.complete(),
			  ['<C-e>'] = cmp.mapping.abort(),
			  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			  ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			-- configure lspkind for vscode-like icons
			-- formatting = {
			-- 	format = lspkind.cmp_format({
			-- 		maxwidth = 50,
			-- 		ellipsis_char = "...",
			-- 	})
			-- },
		}) -- setup

		-- from https://github.com/windwp/nvim-autopairs?tab=readme-ov-file#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
		-- If you want insert `(` after select function or method item
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		cmp.event:on(
		  'confirm_done',
		  cmp_autopairs.on_confirm_done()
		)

	end -- config
}
