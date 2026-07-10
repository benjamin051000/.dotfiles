return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-context", -- sticky headers
		opts = {
			enabled = true
		}
	}
}
