vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') 
vim.keymap.set("n", "<leader>", "<Nop>", { noremap = true, silent = true })

-- vim.cmd[[hi MatchParen cterm=bold ctermbg=none ctermfg=red]]

-- Keybinds to make split navigation easier. See `:help wincmd`
vim.keymap.set('n', '<C-left>', '<C-W><', { desc = 'Resize window left' })
vim.keymap.set('n', '<C-right>', '<C-W>>', { desc = 'Resize window right' })
vim.keymap.set('n', '<C-down>', '<C-W>-', { desc = 'Resize window down' })
vim.keymap.set('n', '<C-up>', '<C-W>+', { desc = 'Resize window up' })

vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = 'Move to next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprev<cr>', { desc = 'Move to previous buffer' })
vim.keymap.set('n', '<leader>bk', ':bdelete<cr>', { desc = 'Kill this buffer' })

-- Center cursor when scrolling half-pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "<C-f>", "<C-f>zz")
-- vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Center cursor when jumping between search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Visual mode indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

--------------------
-- Terminal Workflow
--------------------

-- Open terminal in horizontal split
vim.keymap.set("n", "<leader>ts", function()
  vim.cmd("botright split")
  vim.cmd("resize 15")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { desc = "Open terminal below" })

-- Open terminal in vertical split
vim.keymap.set("n", "<leader>tv", function()
  vim.cmd("botright vsplit")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { desc = "Open terminal right" })

-- Navigate windows directly from terminal mode
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- Terminal mode: close terminal window
vim.keymap.set("t", "<C-q>", "<C-\\><C-n><cmd>close<CR>", {
  desc = "Close terminal window"
})

-- Enter terminal mode when entering terminal buffer
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})
