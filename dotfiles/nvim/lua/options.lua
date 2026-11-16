vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = nv
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 4
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.syntax = on
vim.opt.signcolumn = "yes"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim. See `:help 'clipboard'`
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)


vim.opt.scrolloff = 10

vim.opt.confirm = true

