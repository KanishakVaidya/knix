local g = vim.g
local o = vim.o

o.number = true
o.relativenumber = true
o.mouse = nv
o.linebreak = true
o.breakindent = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.scrolloff = 4
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.cursorline = true
o.syntax = on

o.splitright = true
o.splitbelow = true

o.cursorline = true

-- Don't show the mode, since it's already in the status line
o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() o.clipboard = 'unnamedplus' end)


-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') 

g.mapleader = ' '
g.maplocalleader = ' '

vim.cmd[[hi MatchParen cterm=bold ctermbg=none ctermfg=red]]

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-left>', '<C-W><', { desc = 'Resize window left' })
vim.keymap.set('n', '<C-right>', '<C-W>>', { desc = 'Resize window right' })
vim.keymap.set('n', '<C-down>', '<C-W>-', { desc = 'Resize window down' })
vim.keymap.set('n', '<C-up>', '<C-W>+', { desc = 'Resize window up' })
