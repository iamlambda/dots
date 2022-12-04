local set = vim.opt

set.number = true
set.relativenumber = true
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.swapfile = false

vim.g.catppuccin_flavour = "mocha"
require("catppuccin").setup()
vim.cmd('colorscheme catppuccin')

return require('packer').startup(function()
    use { "catppuccin/nvim", as = "catppuccin" }
    use "tpope/vim-commentary"
end)
