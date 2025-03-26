-- General settings and keymaps

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false

-- set leader key to spacebar (instead of \)
vim.g.mapleader = " "

-- fun one
-- vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- Remap pageup and pagedown to also center screen
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
-- Center screen (horizontal and vertical) when using n/N
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Remap Ctrl-C to Esc, which triggers events that LSPs need to update.
-- Also, allows use of 3iabc<Esc> and 3iabc<C-c> to repeat inserts
map("i", "<C-c>", "<Esc>")

vim.opt.undofile = true
