return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				-- ensure_installed = "all",
				auto_install = true,
				highlight = {
					enable = true,
					-- Example (from README) that disables highlight for large files
					-- disable = function(lang, buf)
					-- 	local max_filesize = 100 * 1024 -- 100 KB
					-- 	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					-- 	if ok and stats and stats.size > max_filesize then
					-- 		return true
					-- 	end
					-- end,
				},
				-- autopairs = {enable = true},
				indent = { enable = true },
				-- incremental_selection = {
				-- 	enable = true,
				-- 	keymaps = {
				-- 		init_selection = "<C-space>",
				-- 		node_incremental = "<C-space>",
				-- 		scope_incremental = false,
				-- 		node_decremental = "<bs>",
				-- 	}
				-- }
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context", -- sticky headers
		opts = {
			enabled = true
		}
	}
}
