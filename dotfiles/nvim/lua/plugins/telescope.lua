-- Dependencies
local telescope_plugins = {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-ui-select.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nvim-telescope/telescope-file-browser.nvim"
}

vim.pack.add(telescope_plugins)

local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

-- Customization
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = actions.which_key,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,

        ["<M-j>"] = actions.preview_scrolling_down,
        ["<M-k>"] = actions.preview_scrolling_up,
      },
      n = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<esc>"] = actions.close,

        ["<M-j>"] = actions.preview_scrolling_down,
        ["<M-k>"] = actions.preview_scrolling_up,
      }
    }
  },
  pickers = { },
  extensions = { 
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  }
}

-- Loading extensions
require("telescope").load_extension "file_browser"


-- Telescope Keymaps

-- Top-level Doom shortcuts
vim.keymap.set('n', '<leader><leader>', builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set("n", "<leader>.", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "Browse files from here" })
vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Switch buffer" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Search project (ripgrep)" })
-- vim.keymap.add("n", "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo tree")

-- [f] File
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope recent files' })
vim.keymap.set( 'n', '<leader>fp', function() builtin.find_files({ cwd = vim.fn.expand("~/.config/nvim")}) end, { desc = "Open private config" })
vim.keymap.set('n', '<leader>fR', ":saveas ", { desc = "Rename/copy file" })
vim.keymap.set('n', '<leader>fD', function() 
  os.remove(vim.fn.expand("%")); vim.cmd("bdelete!") 
end, { desc = "Delete this file" })


-- [g] Git (Magit style)
-- vim.keymap.set('n', "<leader>gg", ":Neogit<cr>", desc = "Neogit status (Magit)" },
vim.keymap.set('n', "<leader>gb", builtin.git_branches, { desc = "Switch branch" })
vim.keymap.set('n', "<leader>gc", builtin.git_commits, { desc = "Git log/commits" })
vim.keymap.set('n', "<leader>gs", builtin.git_status, { desc = "Git status files" })
-- vim.keymap.set('n', "<leader>gB", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
-- vim.keymap.set('n', "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff buffer" })
-- vim.keymap.set('n', "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Revert hunk" })


-- [s] Search
vim.keymap.set("n", "<leader>ss", builtin.current_buffer_fuzzy_find, { desc = "Search buffer (Swiper)" })
vim.keymap.set("n", "<leader>sp", builtin.live_grep, { desc = "Search project" })
vim.keymap.set("n", "<leader>si", builtin.lsp_document_symbols, { desc = "Jump to symbol" })
vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "Jump to mark" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Resume last search" })


-- [h] Help
vim.keymap.set("n", "<leader>hf", builtin.help_tags, { desc = "Describe function/help" })
vim.keymap.set("n", "<leader>hk", builtin.keymaps, { desc = "Describe keybindings" })
vim.keymap.set("n", "<leader>hm", builtin.man_pages, { desc = "Man pages" })
vim.keymap.set("n", "<leader>ht", builtin.colorscheme, { desc = "Load theme" })


-- [p] Project
vim.keymap.set("n", "<leader>pf", builtin.git_files, { desc = "Find file in project" })
-- vim.keymap.set("n", "<leader>pp", builtin.projects, { desc = "Switch project" })
vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Search in project" })
vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Switch project buffer" })


-- [c] Code / LSP
-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code action" })
    vim.keymap.set("n", "<leader>cd", builtin.lsp_definitions, { buffer = buf, desc = "Jump to definition" })
    vim.keymap.set("n", "<leader>cD", builtin.lsp_references, { buffer = buf, desc = "Jump to references" })
    vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, { buffer = buf, desc = "Format buffer/region" })
    vim.keymap.set("n", "<leader>ci", builtin.lsp_implementations, { buffer = buf, desc = "Find implementations" })
    -- Fuzzy find all the symbols (variables, functions, types) in your current document.
    vim.keymap.set("n", "<leader>cj", builtin.lsp_document_symbols, { buffer = buf, desc = "Jump to symbol (imenu)" })
    -- Same but for entire project.
    vim.keymap.set("n", "<leader>cJ", builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = "Jump to workspace symbol" })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = buf, desc = "Rename symbol" })
    vim.keymap.set("n", "<leader>cx", builtin.diagnostics, { buffer = buf, desc = "List errors/diagnostics" })
    -- Jump to the type of the word under your cursor.
    -- Useful when you're not sure what type a variable is and you want to see
    -- the definition of its *type*, not where it was *defined*.
    vim.keymap.set("n", "<leader>ct", builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
  end,
})

