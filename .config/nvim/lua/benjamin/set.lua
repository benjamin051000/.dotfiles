-- General settings and keymaps

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true

-- Disable search highlight
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- Remap Ctrl-C to Esc, which triggers events that LSPs need to update.
-- Also, allows use of 3iabc<Esc> and 3iabc<C-c> to repeat inserts
vim.cmd("inoremap <C-c> <Esc>")

-- set leader key to spacebar (instead of \)
vim.g.mapleader = " "

-- fun one
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
