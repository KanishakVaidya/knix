vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.mouse = nv
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.scrolloff = 4

vim.opt.tabstop = 2 -- tabwidth
vim.opt.shiftwidth = 2 -- indent width
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.g.python_indent = {
  open_paren = "shiftwidth()",
  nested_paren = "shiftwidth()",
  continue = "shiftwidth()",
  closed_paren_align_last_line = false,
}

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "100" -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.laststatus = 2 -- per-window statusline (pairs with lualine's globalstatus = false)

vim.opt.cursorline = true
vim.opt.syntax = on

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen" -- scroll behavior when moving horizontal splits

vim.opt.cursorline = true

-- Sync clipboard between OS and Neovim. See `:help 'clipboard'`
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.termguicolors = true


-- Terminal and tmux like workflow
vim.opt.hidden = true -- Keep buffers in memory when hidden
vim.opt.equalalways = true
vim.opt.showtabline = 2 -- show tabline even with one tab
