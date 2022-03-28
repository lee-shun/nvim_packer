-- install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- plugins
require('packer').startup( function(use)
  use { 'wbthomason/packer.nvim'}

  -- commom libs
  use {'nvim-lua/popup.nvim'}
  use {'nvim-lua/plenary.nvim'}

  -- UI
  use {'arcticicestudio/nord-vim'}

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
  use {'voldikss/vim-floaterm'}


  -- languages
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
  -- TODO: there is a bug ...
  use {'Thiago4532/lsp-semantic.nvim',}
  use {'ahmedkhalf/project.nvim',
    config = function() require('plugins.configs.lsp.project') end }


  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('plugins.configs.color')
