-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(_client, bufnr)
	-- Enable symbol completion triggered by <C-x><C-o>
	-- Code completion: <C-x><C-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local opts = { noremap = true, silent = false, buffer = bufnr }
	local buf = vim.lsp.buf

	local map = function(keys, func, desc, mode)
		mode = mode or 'n'
		vim.keymap.set(mode, keys, func, opts)
	end

	map("gD", buf.declaration, opts) -- go to Declaration
	map("gd", buf.definition, opts) -- go to Definition
	map("gi", buf.implementation, opts)
	map("<C-space>", buf.hover, opts) -- hover gives details about the symbol the cursor is on

	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

	map("<space>wa", buf.add_workspace_folder, opts)
	map("<space>wr", buf.remove_workspace_folder, opts)
	map("<space>wl", function()
		print(vim.inspect(buf.list_workspace_folders()))
	end, opts)
	map("<space>D", buf.type_definition, opts)
	map("<space>rn", buf.rename, opts)
	map("<space>ca", buf.code_action, opts)
	map("gr", buf.references, opts)
	-- TODO BUG sometimes this doesn't show up, like for stylua (which doesn't have an lsp here...)
	map("<space>f", buf.format, opts)

	map("<space>e", vim.diagnostic.open_float, opts)
	map("[d", vim.diagnostic.goto_prev, opts)
	map("]d", vim.diagnostic.goto_next, opts)
	map("<space>q", vim.diagnostic.setloclist, opts)

	-- format_on_save(bufnr)
end

return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{"williamboman/mason.nvim", config = true },
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = "VeryLazy",
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
			-- ["rust_analyzer"] = function ()
			-- 	require("rust-tools").setup {}
			-- end
		}

	end
}
