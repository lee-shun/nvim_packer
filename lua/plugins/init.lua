-- install packer
local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  Packer_bootstrap = vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

-- plugins
require("packer").startup( function(use)
  use { "wbthomason/packer.nvim"}

  -- commom libs
  use {"nvim-lua/popup.nvim"}
  use {"nvim-lua/plenary.nvim"}

  -- UI
  use{"kyazdani42/nvim-web-devicons"}
  use{"sainnhe/sonokai",
    config = function()
      vim.g.sonokai_better_performance = 1
      vim.cmd("colorscheme sonokai")
    end}
  use {"folke/tokyonight.nvim",
    disable = true,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end}
  use { "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons",
      opt = true },
    config = function()
      require("plugins.configs.statusline.eviline")
    end}
  use {"glepnir/dashboard-nvim",
    config = function()
      require("plugins.configs.dashboard")
    end}
  use {"RRethy/vim-illuminate",
    event = "BufReadPre",
    config = function ()
      require("illuminate").configure({})
    end}

  -- file navgative
  use {"kyazdani42/nvim-tree.lua",
    cmd = {"NvimTreeToggle", "NvimTreeClose"},
    requires = {"kyazdani42/nvim-web-devicons", opt = true,},
    config = function()
      require("plugins.configs.nvimtree")
    end}
  use {"nvim-telescope/telescope.nvim",requires = {"nvim-lua/plenary.nvim"},
    config = function()
      require("plugins.configs.telescope")
    end}

  -- general enchance
  use {"lewis6991/impatient.nvim",
    configs = function()
      require("impatient")
    end}
  use {
    "windwp/nvim-autopairs",
    wants = "nvim-treesitter",
    module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
    config = function()
      require("plugins.configs.autopairs").setup()
    end,
  }
  use {"numToStr/Comment.nvim", event = "BufReadPre",
    config = function()
      require("Comment").setup{}
    end}
  use {"norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup{}
    end}
  use {"nvim-treesitter/nvim-treesitter", run =":TSUpdate",
    config = function()
      require("plugins.configs.treesitter")
    end}
  use {"nvim-treesitter/playground"}
  use {"p00f/nvim-ts-rainbow"}
  use {"akinsho/toggleterm.nvim",
    config = function()
      require("plugins.configs.toggleterm")
    end}
  use {"is0n/fm-nvim",
    event = "BufReadPost",
    config = function()
      require("fm-nvim").setup{}
      vim.api.nvim_set_keymap("n", "<Leader>ra", "<cmd>Ranger<CR>", {noremap = true, silent = true})
    end}
  use {"voldikss/vim-floaterm",
    config = function ()
      vim.g.floaterm_keymap_toggle = "<F12>"
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.7
    end,
    disable=true}
  use {"folke/todo-comments.nvim",
    config = function()
      require("plugins.configs.todo_comments")
    end}
  use {"lewis6991/gitsigns.nvim", event = "BufReadPost",
    config = function()
      require("gitsigns").setup{}
    end}
  use {"sbdchd/neoformat",
    cmd = "Neoformat"}
  use {"psliwka/vim-smoothie"}
  use {"AckslD/nvim-neoclip.lua",
    requires = {
      {"nvim-telescope/telescope.nvim"},
    },
    config = function()
      require("neoclip").setup()
      require("telescope").load_extension("neoclip")
    end,
    event = "BufReadPost",
  }


  use{"kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end
  }
  use {"liuchengxu/vista.vim"}
  use {"rlue/vim-barbaric",
    event="BufReadPost"}
  use {"lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("plugins.configs.indent_blankline")
    end}
  use {"mg979/vim-visual-multi"}
  use {"junegunn/vim-easy-align"}
  use {"rhysd/conflict-marker.vim"}
  use {"tpope/vim-fugitive",
    cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" }}
  use {"mbbill/undotree",
    cmd = "UndotreeToggle "}
  use{ "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup()
    end}
  use {"wellle/targets.vim"}
  use {"Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {}
    end}
  use {"voldikss/vim-translator",
    cmd="TranslateW"}

  -- code runner
  use { "pianocomposer321/yabs.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.configs.yabs") end,
    event = "BufReadPost" }

  -- completion
  use {"hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("plugins.configs.lsp.cmp")
    end,
    wants = { "LuaSnip" },
    requires = {
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"hrsh7th/cmp-cmdline"},
      {"tzachar/cmp-tabnine", run="./install.sh"},
      {"saadparwaiz1/cmp_luasnip"},
      {"L3MON4D3/LuaSnip",
        wants = { "friendly-snippets", "vim-snippets" },
        config = function()
          require("plugins.configs.luasnip").setup()
        end},
      {"rafamadriz/friendly-snippets"},
      {"honza/vim-snippets"},
    },
  }

  -- lsp
  use {"neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require("plugins.configs.lsp.lspconfig")
    end,
    wants = {"cmp-nvim-lsp"},
    requires = {
      {"Thiago4532/lsp-semantic.nvim"},
      {"folke/lsp-colors.nvim", -- not work with sonokai
        config = function()
          require("lsp-colors").setup ()
        end,
        disable = true}
    } }

  use {"ahmedkhalf/project.nvim",
    config = function()
      require("plugins.configs.lsp.project")
    end}

  use {"folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("trouble").setup {}
    end}

  -- linters
  use {"mfussenegger/nvim-lint",
    config=function()
      require("plugins.configs.nvim_linter")
    end,
    event="BufReadPre"}

  -- language
  use {"taketwo/vim-ros",
    ft =  {"rosmsg", "cpp"},
    cmd = "Roscd"}
  use {"thibthib18/ros-nvim",
    ft =  {"rosmsg", "cpp"}}
  use {"lervag/vimtex",
    ft = "tex"}
  use {"iamcco/markdown-preview.nvim",
    run=":call mkdp#util#install()",
    ft ={"markdown"},
    config = function ()
      vim.cmd([[
        function! g:Open_browser(url)
        silent exec "!google-chrome --password-store=gnome --new-window " . a:url . " &"
        endfunction
        ]])
      vim.g.mkdp_browser = "google-chrome"
      vim.g.mkdp_browserfunc = "g:Open_browser"
    end}
  use {'nvim-orgmode/orgmode',
    config = function()
      require('orgmode').setup_ts_grammar()
      require('orgmode').setup({
        org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
        org_default_notes_file = '~/Dropbox/org/refile.org',
      })
    end
  }


  if Packer_bootstrap then
    require("packer").sync()
  end
end)
