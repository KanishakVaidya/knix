-- Global configs
vim.loader.enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_fonts = true

-- Modules
require("options")
require("keymap")
require("theming")
require("lsp")
require("netrw")
require("plugins")
