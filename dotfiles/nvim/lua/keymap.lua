-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') 

-- vim.cmd[[hi MatchParen cterm=bold ctermbg=none ctermfg=red]]

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

vim.keymap.set('n', '<Tab>', ':bnext<cr>', { desc = 'Move to next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprev<cr>', { desc = 'Move to previous buffer' })

