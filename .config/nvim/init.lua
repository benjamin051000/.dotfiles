-- Helpful resource: https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
require("benjamin.set")
require("benjamin.telescope")


local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
-- Remap pageup and pagedown to also center screen
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
-- Center screen (horizontal and vertical) when using n/N
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

vim.opt.undofile = true

