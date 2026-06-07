-- to automatically install and set up pckr.nvim following snippet before your first usage of pckr is required

local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{

  {
    "tomasiser/vim-code-dark",
    config = function()
      -- vim.g.base16colorspace = 256
      -- vim.o.termguicolors = true
      vim.cmd.colorscheme("codedark")
    end
  };

  {
    "itchyny/lightline.vim",
    config = function()
      vim.g.showmode = false
    end
  };

}
