vim.pack.add({
  "https://github.com/nvimdev/lspsaga.nvim"
})

require('lspsaga').setup({
  symbol_in_winbar = {
    enable = true,
  }
})
