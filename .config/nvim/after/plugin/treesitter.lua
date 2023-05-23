-- Treesitter
require 'nvim-treesitter.configs'.setup {
    -- ensure_installed = "all",
    ignore_install = {""},
    auto_install = true,    
    
    highlight = {enable = true},
    -- autopairs = {enable = true},
    indent = {enable = true}

}


-- Treesitter context
-- require 'nvim-treesitter-context'.setup {}
