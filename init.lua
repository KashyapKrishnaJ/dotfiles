-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = { 
    -- add your plugins here
    {"catppuccin/nvim", name = "catppuccin", priority = 1000},
    {'nvim-telescope/telescope.nvim', tag = '0.1.8', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep', 'sharkdp/fd'}},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"nvim-tree/nvim-tree.lua", version = "*", lazy = false, dependencies = {"nvim-tree/nvim-web-devicons"}},
    {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }}
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = true }
})

local builtin = require("telescope/builtin")
vim.keymap.set('n', '<C-p>', function() builtin.find_files({cwd = "/home/Kashyap", hidden = true, file_ignore_patterns = {".cache", ".local", "librewolf"}}) end, {})
vim.keymap.set('n', '<C-f>', function() builtin.live_grep({cwd = "/home/Kashyap", hidden = true, file_ignore_patterns = {".cache", ".local", "librewolf"}}) end, {})

require("lazy").setup({{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "c++", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "css", "c#", "python","java", "rust", "markdown"},
          sync_install = true,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
 }})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
require("nvim-web-devicons")
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
vim.keymap.set('n', '<C-b>', ":NvimTreeFindFileToggle<cr>")
require("lualine").setup()

vim.cmd("set nowrap")
vim.cmd("set nu!")
