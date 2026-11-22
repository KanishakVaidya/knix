vim.pack.add({
  "https://github.com/folke/which-key.nvim"
})

local wk = require("which-key")

-- Keymap groups
wk.add({
  { "<leader>f", group = "file" },
  { "<leader>b", group = "buffer" },
  { "<leader>w", proxy="<c-w>", group = "window" },
  { "<leader>s", group = "search" },
  { "<leader>c", group = "code/LSP" },
  { "<leader>g", group = "git" },
  { "<leader>h", group = "help" },
  { "<leader>o", group = "open" },
})


vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') 
vim.keymap.set("n", "<leader>", "<Nop>", { noremap = true, silent = true })

-- vim.cmd[[hi MatchParen cterm=bold ctermbg=none ctermfg=red]]

-- Keybinds to make split navigation easier. See `:help wincmd`
vim.keymap.set('n', '<C-left>', '<C-W><', { desc = 'Resize window left' })
vim.keymap.set('n', '<C-right>', '<C-W>>', { desc = 'Resize window right' })
vim.keymap.set('n', '<C-down>', '<C-W>-', { desc = 'Resize window down' })
vim.keymap.set('n', '<C-up>', '<C-W>+', { desc = 'Resize window up' })

-- [b] Buffers
vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = 'Move to next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprev<cr>', { desc = 'Move to previous buffer' })
vim.keymap.set('n', '<leader>bk', ':bdelete<cr>', { desc = 'Kill this buffer' })
vim.keymap.set("n", "<leader>`", ":b#<cr>", { desc = "Switch to last buffer" })


-- [w] Window
vim.keymap.set("n",  "<leader>wv", ":vsplit<cr>", { desc = "Split vertical" })
vim.keymap.set("n",  "<leader>ws", ":split<cr>", { desc = "Split horizontal" })
vim.keymap.set("n",  "<leader>wc", ":close<cr>", { desc = "Close window" })
vim.keymap.set("n",  "<leader>wd", ":close<cr>", { desc = "Delete window" })
vim.keymap.set("n",  "<leader>wo", ":only<cr>", { desc = "Maximize window (delete others)" })
vim.keymap.set("n",  "<leader>wh", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n",  "<leader>wj", "<C-w>j", { desc = "Focus down window" })
vim.keymap.set("n",  "<leader>wk", "<C-w>k", { desc = "Focus up window" })
vim.keymap.set("n",  "<leader>wl", "<C-w>l", { desc = "Focus right window" })
vim.keymap.set("n",  "<leader>ww", "<C-w>w", { desc = "Cycle windows" })
vim.keymap.set("n",  "<leader>w=", "<C-w>=", { desc = "Balance windows" })


-- [o] Open
-- vim.keymap.add("n", "<leader>o", group = "open")
-- vim.keymap.add("n", "<leader>op", "<cmd>Neotree toggle<cr>", desc = "Project sidebar (Treemacs)")
-- vim.keymap.add("n", "<leader>o-", "<cmd>Oil<cr>", desc = "Open dired (Oil)")
-- vim.keymap.add("n", "<leader>ot", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Open terminal popup")
-- vim.keymap.add("n", "<leader>oT", "<cmd>ToggleTerm direction=float<cr>", desc = "Open fullscreen terminal")


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
