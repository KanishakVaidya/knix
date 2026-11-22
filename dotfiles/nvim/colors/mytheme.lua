-- mytheme.nvim
-- Basic Neovim colorscheme

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "mytheme"
vim.o.termguicolors = true

-- Palette
local colors = {
  bg0      = "#151515",
  bg       = "#1e1e1e",
  bg1      = "#222222",
  bg2      = "#505050",

  fg0      = "#ffffff",
  fg       = "#d4d4d4",
  fg1      = "#a0a0a0",
  fg2      = "#555555",

  red      = "#f44747",
  green    = "#608b4e",
  yellow   = "#d7ba7d",
  blue     = "#569cd6",
  purple   = "#c586c0",
  cyan     = "#9cdcfe",
  orange   = "#de935f",

  dimred      = "#f44747",
  dimgreen    = "#608b4e",
  dimyellow   = "#c6a96c",
  dimblue     = "#264f78",
  dimpurple   = "#c586c0",
  dimcyan     = "#9cdcfe",

  comment  = "#de935f",
}

-- Highlight helper
local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor
hi("Normal",       { fg = colors.fg, bg = colors.bg })
hi("NormalFloat",  { fg = colors.fg, bg = colors.bg0 })
hi("CursorLine",   { bg = colors.bg1 })
hi("LineNr",       { fg = colors.fg2 })
hi("CursorLineNr", { fg = colors.fg1, bold = false })
hi("Visual",       { bg = colors.dimblue })
hi("Search",       { fg = colors.bg, bg = colors.dimyellow })
hi("Comment",      { fg = colors.yellow, bg = colors.bg1, italic = true, bold = true })

-- Syntax
hi("String",       { fg = colors.green })
hi("Number",       { fg = colors.peach or colors.orange })
hi("Boolean",      { fg = colors.orange })  -- boolean is a number
hi("Function",     { fg = colors.blue, bold = false })
hi("Keyword",      { fg = colors.fg1, bold = false })
hi("Type",         { fg = colors.blue })
hi("Constant",     { fg = colors.orange or colors.purple })
hi("Identifier",   { fg = colors.blue })
hi("Statement",    { fg = colors.purple })
hi("Operator",     { fg = colors.fg })
hi("Special",      { fg = colors.fg1 })

-- Diagnostics
hi("DiagnosticError", { fg = colors.red })
hi("DiagnosticWarn",  { fg = colors.yellow })
hi("DiagnosticInfo",  { fg = colors.blue })
hi("DiagnosticHint",  { fg = colors.cyan })

-- UI
hi("Pmenu",         { fg = colors.fg, bg = colors.bg1 })
hi("PmenuSel",      { fg = colors.bg, bg = colors.blue })
hi("StatusLine",    { fg = colors.fg, bg = colors.bg1 })
hi("VertSplit",     { fg = colors.fg1 })
