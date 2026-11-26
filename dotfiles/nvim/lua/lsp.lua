vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.lsp.enable({ 'basedpyright', 'ty' })

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.ERROR } },

  -- Can switch between these as you prefer
  virtual_text = false, -- Text shows up at the end of the line
  virtual_lines = true, -- Text shows up underneath the line, with virtual lines
  -- virtual_text = { format = function(d) return "" end },
  -- signs = flase,

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

-- vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy', 'popup' }
-- vim.opt.autocomplete = true
-- vim.opt.complete:append('o,.')
-- vim.opt.pumheight = 5
-- vim.opt.pumwidth = 80
-- vim.opt.pumborder = 'rounded'
-- 
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
--     end
--   end,
-- })


vim.keymap.set('i', '<C-j>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  else
    return '<C-j>'
  end
end, { expr = true })

vim.keymap.set('i', '<C-k>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-p>'
  else
    return '<C-k>'
  end
end, { expr = true })
