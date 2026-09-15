vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.lsp.enable({ 'basedpyright' })

vim.diagnostic.config({ virtual_text = true })

vim.opt.completeopt = { 'menuone', 'noselect', 'fuzzy', 'popup' }
vim.opt.autocomplete = true
vim.opt.complete:append('o')
vim.opt.pumheight = 5
-- vim.opt.pumborder = 'rounded'

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
    end
  end,
})


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

-- vim.keymap.set('i', '<CR>', function()
--   if vim.fn.pumvisible() == 1 then
--     return '<C-y>'
--   else
--     return '<CR>'
--   end
-- end, { expr = true })
