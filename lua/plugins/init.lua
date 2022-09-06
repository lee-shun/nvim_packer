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
  use{'kyazdani42/nvim-web-devicons'}
  use {'folke/tokyonight.nvim',
    config = function() vim.cmd('colorscheme tokyonight') end}
  use {'machakann/vim-highlightedyank'}
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('plugins.configs.statusline.eviline') end}
  use {'glepnir/dashboard-nvim',
    config = function() require('plugins.configs.dashboard') end}

  -- file navgative
  use {'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true, cmd = {"NvimTreeToggle", "NvimTreeClose"},},
    config = function() require('plugins.configs.nvimtree') end }
  use {'nvim-telescope/telescope.nvim',requires = {'nvim-lua/plenary.nvim'},
    config = function() require('plugins.configs.telescope') end }

  -- general enchance
  use {'lewis6991/impatient.nvim',
    configs = function() require('impatient') end}
  use {'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup{
      ignored_next_char = ''} end }
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
  use {'lewis6991/gitsigns.nvim', event = "BufReadPre",
    config = function() require('gitsigns').setup{} end }
  use {'sbdchd/neoformat', cmd = 'Neoformat'}
  use {'psliwka/vim-smoothie'}
  use {'junegunn/vim-peekaboo'}
  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'liuchengxu/vista.vim'}
  use {'rlue/vim-barbaric'}
  use {'lukas-reineke/indent-blankline.nvim', event = "BufReadPre",
    config = function() require('plugins.configs.indent_blankline') end }
  use {'RRethy/vim-illuminate',
    config = function ()
      vim.g.Illuminate_ftblacklist = "['python', 'Nvimtree']"
    end}
  use {'mg979/vim-visual-multi'}
  use {'godlygeek/tabular'}
  use {'junegunn/vim-easy-align'}
  use {'rhysd/conflict-marker.vim'}
  use {'tpope/vim-fugitive', cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" }}
  use {'mbbill/undotree', cmd = 'UndotreeToggle '}
  use {'lambdalisue/readablefold.vim'}
  use {'wellle/targets.vim'}
  use {'Pocco81/auto-save.nvim',
    config = function () require("auto-save").setup {}
    end}

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
  use {'Thiago4532/lsp-semantic.nvim'}
  use {'ahmedkhalf/project.nvim',
    config = function() require('plugins.configs.lsp.project') end }
  use {'onsails/lspkind-nvim',
    config = function() require('plugins.configs.lsp.lspkind') end }
  use {'folke/lsp-colors.nvim',
    config = function () require("lsp-colors").setup {} end}
  use {'folke/trouble.nvim',
    config = function () require("trouble").setup {} end}

  -- linters
  use {'mfussenegger/nvim-lint',
    config=function () require("plugins.configs.nvim_linter") end}

  -- language
  use {'taketwo/vim-ros', ft =  {'rosmsg', 'cpp'}, cmd = 'Roscd'}
  use {'thibthib18/ros-nvim', ft =  {'rosmsg', 'cpp'}}
  use {'lervag/vimtex', ft = 'tex'}
  use {'SidOfc/mkdx', ft={'markdown'},
    config = function ()
      vim.cmd([[
        let g:mkdx#settings = {
                    \'highlight': { 'enable': 0 },
                    \'map': { 'prefix': '=' }
                    \}
            ]])
    end}
  use {'iamcco/markdown-preview.nvim', run=':call mkdp#util#install()', ft ={'markdown'},
    config = function ()
      vim.cmd([[
        function! g:Open_browser(url)
        silent exec "!google-chrome --password-store=gnome --new-window " . a:url . " &"
        endfunction
        ]])
      vim.g.mkdp_browser = 'google-chrome'
      vim.g.mkdp_browserfunc = 'g:Open_browser'
    end}
  use {'dhruvasagar/vim-table-mode',  cmd = 'TableModeToggle', ft = {'markdown'}}
  use {'lee-shun/vim-markdown-wiki', ft = {'markdown'}}

  use {'numirias/semshi', run=':UpdateRemotePlugins', ft={'python'}}
  use {'mboughaba/i3config.vim', ft={'i3config'}}


  if Packer_bootstrap then
    require('packer').sync()
  end
end)
