vim.pack.add({
  "https://github.com/tomasiser/vim-code-dark",
  "https://github.com/itchyny/lightline.vim",

  "https://github.com/nvimdev/indentmini.nvim"
})


-- Colorsscheme
vim.cmd.colorscheme("codedark")
-- vim.api.nvim_set_hl(0, 'Normal', { bg = "none" })
vim.g.showmode = false



-- Indent Guides

--[[ IndentMini Configuration

## Configuration
| Key              | Description                                   | Default                   |
|------------------|-----------------------------------------------|---------------------------|
| char             | Character to draw the indentation guides      | `<BAR>`                   |
| enabled          | Default state of the plugin                   | `true`                    |
| exclude          | Disable in these filetypes                    | `{}`                      |
| exclude_nodetype | TreeSitter classes where guides are not drawn | `{}`                      |
| key              | Hotkey to toggle the guides                   | `''`                      |
| minlevel         | Minimum level where indentation is drawn      | `0`                       |
| only_current     | only highlight current indentation level      | `false`                   |

--]]

require("indentmini").setup({
  key = '<F5>',
  minlevel = 2
})
