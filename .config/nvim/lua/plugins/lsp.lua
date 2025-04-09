-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(_, bufnr)
	-- Enable symbol completion triggered by <C-x><C-o>
	-- Code completion: <C-x><C-o>
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local buf = vim.lsp.buf

	local map = function(keys, func, desc, mode)
		mode = mode or 'n'
		local opts = { noremap = true, silent = false, buffer = bufnr, desc = desc }
		vim.keymap.set(mode, keys, func, opts)
	end

	map("gD", buf.declaration, "go to [D]eclaration")
	map("gd", buf.definition, "go to [d]efinition")
	map("gi", buf.implementation, "go to [i]mplementation")
	map("gr", buf.references, "go to [r]eferences")
	map("<C-space>", buf.hover, "hover")

	map("<C-k>", buf.signature_help, "signature help")

	map("<space>wa", buf.add_workspace_folder)
	map("<space>wr", buf.remove_workspace_folder)
	map("<space>wl", function()
		print(vim.inspect(buf.list_workspace_folders()))
	end)
	map("<space>D", buf.type_definition, "type definition")
	map("<space>rn", buf.rename, "rename symbol")
	map("<space>ca", buf.code_action, "code action")
	-- TODO BUG sometimes this doesn't show up, like for stylua (which doesn't have an lsp here...)
	map("<space>f", buf.format, "format file")

	map("<space>e", vim.diagnostic.open_float, "open diagnostic float")
	-- These are mostly overshadowed by trouble.nvim
	-- map("[d", vim.diagnostic.goto_prev, "previous diagnostic")
	-- map("]d", vim.diagnostic.goto_next, "next diagnostic")
	-- map("<space>q", vim.diagnostic.setloclist)

	-- format_on_save(bufnr)
end

return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{"williamboman/mason.nvim", config = true, lazy = false },
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = {"BufReadPre", "BufNewFile"},
	config = function()
		require("mason-lspconfig").setup()

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("mason-lspconfig").setup_handlers {
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function (server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
			-- Next, you can provide a dedicated handler for specific servers.
			-- For example, a handler override for the `rust_analyzer`:
			["lua_ls"] = function ()
				require("lspconfig").lua_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						Lua = {
							workspace = {
								library = {
									vim.env.VIMRUNTIME,
								}
							}
						}
					}
				}) -- setup
			end,
		} -- setup_handlers

	end
}
