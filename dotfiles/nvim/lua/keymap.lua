vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') 

-- vim.cmd[[hi MatchParen cterm=bold ctermbg=none ctermfg=red]]

-- Keybinds to make split navigation easier. See `:help wincmd`
vim.keymap.set('n', '<C-left>', '<C-W><', { desc = 'Resize window left' })
vim.keymap.set('n', '<C-right>', '<C-W>>', { desc = 'Resize window right' })
vim.keymap.set('n', '<C-down>', '<C-W>-', { desc = 'Resize window down' })
vim.keymap.set('n', '<C-up>', '<C-W>+', { desc = 'Resize window up' })

vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = 'Move to next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprev<cr>', { desc = 'Move to previous buffer' })

-- Center cursor when scrolling half-pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Center cursor when jumping between search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
