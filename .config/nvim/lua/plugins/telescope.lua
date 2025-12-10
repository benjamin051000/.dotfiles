return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- 'nvim-telescope/telescope-ui-select.nvim',

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

		-- "nvim-telescope/telescope-frecency.nvim",
	},
	keys = { "<leader>ff", "<leader>fg", "<leader>fb", "<leader>fh" },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

		-- pcall(require('telescope').load_extension, "frecency")
		-- pcall(require('telescope').load_extension, "ui-select")
	end
}
