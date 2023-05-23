-- Set up lspconfig with nvim-cmp.
local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lspconfig default settings
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = false }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Shamelessly stolen from https://github.com/AlphaKeks/home/blob/master/.config/nvim/after/plugin/lsp.lua#L94-102
local function format_on_save(bufnr)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = format_group,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format()
		end,
	})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable symbol completion triggered by <C-x><C-o>
	-- Code completion: <C-x><C-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = false, buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- go to Declaration
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- go to Definition
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-space>", vim.lsp.buf.hover, bufopts) -- hover gives details about the symbol the cursor is on

	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	-- TODO BUG sometimes this doesn't show up, like for stylua (which doesn't have an lsp here...)
	vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)

	format_on_save(bufnr)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

require("lspconfig").pyright.setup({
	capabilities = default_capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig")["tsserver"].setup({
	capabilities = default_capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
})

local rt = require("rust-tools")
rt.setup({
	server = {
		on_attach = function(client, bufnr)
			-- Run the normal on_attach function for all LSP stuffs
			on_attach(client, bufnr)

			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,

		capabilities = default_capabilities,

		settings = {
			-- See settings here: https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
			-- and here: https://hw0lff.github.io/rust-analyzer-docs/2022-07-04/index.html#rust-analyzer_cargo_buildscripts_enable
			["rust-analyzer"] = {
				-- For now, let's just stick with the defaults.

				-- imports = {
				-- 	granularity = {
				-- 		group = "module",
				-- 	},
				-- 	prefix = "self",
				-- },
			},
		}, -- end of settings
	}, -- end of server
})

-- c/c++
require("lspconfig").clangd.setup({
	capabilities = default_capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
})

-- require 'lspconfig'.shellcheck.setup{
--     capabilities = default_capabilities,
--     on_attach = on_attach,
--     flags = lsp_flags
-- }

-- lsp lines
require("lsp_lines").setup()

vim.diagnostic.config({
	virtual_text = false,
})

require("lspconfig").lua_ls.setup({
	capabilities = default_capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
})

vim.keymap.set("", "<leader>el", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
