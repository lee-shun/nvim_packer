-- install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  Packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- plugins
require('packer').startup( function(use)
  use { 'wbthomason/packer.nvim'}

  -- commom libs
  use {'nvim-lua/popup.nvim'}
  use {'nvim-lua/plenary.nvim'}

  -- UI
  use {'arcticicestudio/nord-vim',
    config = function() vim.cmd('colorscheme nord') end}
  use {'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() require('plugins.configs.statusline.eviline') end}
  use {'glepnir/dashboard-nvim',
    config = function() require('plugins.configs.dashboard') end}

  -- file navgative
  use {'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('plugins.configs.nvimtree') end }
  use {'nvim-telescope/telescope.nvim',
    config = function() require('plugins.configs.telescope') end }

  -- general enchance
  use {'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup{} end }
  use {'numToStr/Comment.nvim',
    config = function() require('Comment').setup{} end }
  use {'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup{} end }
  use {'nvim-treesitter/nvim-treesitter', run =':TSUpdate',
    config = function() require('plugins.configs.treesitter') end }
  use {'nvim-treesitter/playground'}
  use {'p00f/nvim-ts-rainbow'}
  use {'voldikss/vim-floaterm',
    config = function ()
      vim.g.floaterm_keymap_toggle = '<F12>'
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.7
    end}
  use {'folke/todo-comments.nvim',
    config = function() require('plugins.configs.todo_comments') end }
  use {'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup{} end }
  use {'sbdchd/neoformat'}

  -- lsp
  use {'neovim/nvim-lspconfig',
    config = function() require('plugins.configs.lsp.lspconfig') end }
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}
  use {'hrsh7th/nvim-cmp',
    config = function() require('plugins.configs.lsp.cmp') end }
  use {'hrsh7th/cmp-vsnip'}
  use {'hrsh7th/vim-vsnip'}
  use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
  -- TODO: there is a bug ...
  use {'Thiago4532/lsp-semantic.nvim'}
  use {'ahmedkhalf/project.nvim',
    config = function() require('plugins.configs.lsp.project') end }
  use {'onsails/lspkind-nvim',
    config = function() require('plugins.configs.lsp.lspkind') end }
  -- use {'glepnir/lspsaga.nvim',
  --   config = function() require('plugins.configs.lsp.lspsaga') end }
  use {'folke/lsp-colors.nvim'}
  use {'folke/trouble.nvim'}
  use {'lewis6991/spellsitter.nvim'}

  if Packer_bootstrap then
    require('packer').sync()
  end
end)
