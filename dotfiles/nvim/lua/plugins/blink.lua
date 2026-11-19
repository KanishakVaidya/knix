vim.pack.add({
  { src='https://github.com/saghen/blink.cmp', version=vim.version.range('1.x') }
})

-- Plugin configuration
require('blink.cmp').setup({
  keymap = { 
    preset = 'default' ,
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    -- ['<CR>'] = { 'select_and_accept', 'fallback' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
  },

  appearance = {
    nerd_font_variant = 'mono'
  },

  completion = {
    menu = { border = 'rounded' },
    documentation = { 
      auto_show = false,
      -- window = { border = 'single' }
    },
    trigger = { show_on_trigger_character = true },
    list = { selection = {
      preselect = false,
      auto_insert = true
    }}
  },

  signature = {
    enabled = true,
    window = { border = 'single' } 
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  
  -- Disable cmdline
  cmdline = { enabled = false },

  fuzzy = {
    implementation = "prefer_rust_with_warning"
  }
})
