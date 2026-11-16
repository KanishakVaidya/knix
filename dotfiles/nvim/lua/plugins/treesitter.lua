vim.pack.add({
  { src="https://github.com/nvim-treesitter/nvim-treesitter"}
})

-- Lazy.nvim have built flag, no such thing for vim.pack
-- This autocmd replaces built flag
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.kind == "install" or ev.data.kind == "update" then
      -- Check if the plugin is the one needing a build step
      if ev.data.spec.name == "nvim-treesitter" then
        vim.cmd("TSUpdate")
      end
    end
  end
})

-- require('nvim-treesitter').setup {
--   -- Directory to install parsers and queries to
--   install_dir = vim.fn.stdpath('data') .. '/site'
-- }

require('nvim-treesitter').install { 'markdown', 'python', 'zig' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'py', 'md' },
  callback = function() vim.treesitter.start() end,
})
