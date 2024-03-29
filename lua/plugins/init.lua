-- install packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- plugins
local plug_list_func = function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "lewis6991/impatient.nvim" }) -- NOTE: this plug should be used in the very first line in the config file

	use({
		"sainnhe/sonokai",
		config = function()
			vim.g.sonokai_better_performance = 1
			vim.g.sonokai_current_word = "grey background"
			vim.g.sonokai_diagnostic_virtual_text = "colored"
			vim.g.sonokai_spell_foreground = "colored"
			vim.cmd("colorscheme sonokai")
		end,
	})

	use({
		"rmehri01/onenord.nvim",
		disable = true,
		config = function()
			vim.cmd("colorscheme onenord")
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		event = "BufReadPre",
		wants = { "nvim-web-devicons" },
		requires = {
			{ "kyazdani42/nvim-web-devicons", opt = true },
		},
		config = function()
			require("plugins.configs.eviline")
		end,
	})

	use({
		"goolord/alpha-nvim",
		wants = { "nvim-web-devicons" },
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.configs.alpha")
		end,
	})

	use({
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		config = function()
			require("plugins.configs.illuminate")
		end,
	})

	-- file navgative
	use({
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeClose" },
		wants = { "nvim-web-devicons" },
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.configs.nvimtree")
		end,
	})

	-- general enchance
	use({
		"folke/which-key.nvim",
        event = "BufReadPre",
		config = function()
			require("plugins.configs.which_key")
		end,
	})

	use({
		"johnfrankmorgan/whitespace.nvim",
		event = { "BufReadPost" },
		config = function()
			require("whitespace-nvim").setup({
				highlight = "DiffDelete",
				ignored_filetypes = { "TelescopePrompt", "alpha", "git", "NvimTree", "toggleterm" },
			})
			vim.api.nvim_create_user_command("TrimWS", "lua require('whitespace-nvim').trim()", {})
		end,
	})

	use({
		"windwp/nvim-autopairs",
		event = "BufReadPre",
		module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
		config = function()
			require("plugins.configs.autopairs").setup()
		end,
	})

	use({
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		cmd = "ColorizerToggle",
		config = function()
			require("colorizer").setup()
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		event = "BufReadPre",
		requires = {
			{ "p00f/nvim-ts-rainbow", opt = true, event = "BufReadPost" },
		},
		config = function()
			require("plugins.configs.treesitter")
		end,
	})

	use({
		"m-demare/hlargs.nvim",
		event = "BufReadPost",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("hlargs").setup({
				color = "#FAD7A0",
			})
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		event = "BufReadPre",
		config = function()
			require("plugins.configs.toggleterm")
		end,
	})

	use({
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		config = function()
			require("plugins.configs.todo_comments")
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({ "psliwka/vim-smoothie", event = "BufReadPost" })

	use({
		"kylechui/nvim-surround",
		event = "BufReadPost",
		config = function()
			require("nvim-surround").setup()
		end,
	})

	use({ "rlue/vim-barbaric", event = "InsertEnter" })

	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			require("plugins.configs.indent_blankline")
		end,
	})

	use({
		"mg979/vim-visual-multi",
		event = "BufReadPost",
		config = function()
			vim.g.VM_maps = { ["I BS"] = "" }
			vim.g.VM_set_statusline = 0
		end,
	})

	use({
		"kevinhwang91/nvim-hlslens",
		event = { "BufReadPost" },
		config = function()
			require("hlslens").setup()
		end,
	})

	use({
		"junegunn/vim-easy-align",
		event = "BufReadPost",
	})

	use({ "rhysd/conflict-marker.vim", event = "BufReadPost" })

	use({ "tpope/vim-fugitive", cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" } })

	use({ "mbbill/undotree", cmd = "UndotreeToggle" })

	use({ "wellle/targets.vim", event = "BufReadPost" })

	use({
		"Pocco81/auto-save.nvim",
		event = "BufReadPost",
		config = function()
			require("auto-save").setup()
		end,
	})

	use({
		"voldikss/vim-translator",
		cmd = "TranslateW",
	})

	-- code runner
	use({
		"pianocomposer321/yabs.nvim",
		event = "BufReadPost",
		requires = { "nvim-lua/plenary.nvim", opt = true },
		config = function()
			require("plugins.configs.yabs")
		end,
	})

	-- completion
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		opt = true,
		wants = {
			"LuaSnip",
		},
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "tzachar/cmp-tabnine", run = "./install.sh" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "lukas-reineke/cmp-under-comparator" },
			{
				"L3MON4D3/LuaSnip",
				opt = true,
				config = function()
					require("plugins.configs.luasnip").setup()
				end,
			},
			{ "rafamadriz/friendly-snippets", opt = true },
		},
		config = function()
			require("plugins.configs.lsp.cmp")
		end,
	})

	-- lsp
	use({
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		opt = true,
		wants = { "nvim-navic", "inc-rename.nvim", "fidget.nvim", "which-key.nvim" },
		requires = {
			{
				"SmiteshP/nvim-navic",
				opt = true,
			},
			{
				"smjonas/inc-rename.nvim",
				opt = true,
				cmd = "IncRename",
				config = function()
					require("inc_rename").setup()
				end,
			},
			{
				"j-hui/fidget.nvim",
				opt = true,
				config = function()
					require("fidget").setup({})
				end,
			},
		},
		config = function()
			require("plugins.configs.lsp.lspconfig")
		end,
	})

	use({
		"folke/trouble.nvim",
		opt = true,
		cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	use({
		"liuchengxu/vista.vim",
		cmd = "Vista",
		config = function()
			vim.g.vista_default_executive = "nvim_lsp"
		end,
	})

	-- manage root
	use({
		"ahmedkhalf/project.nvim",
		event = "BufReadPre",
		config = function()
			require("plugins.configs.lsp.project")
		end,
	})

	-- linters
	use({
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		config = function()
			require("plugins.configs.lsp.null_ls")
		end,
	})

	-- format
	use({
		"mhartington/formatter.nvim",
		cmd = "Format",
		config = function()
			require("plugins.configs.formatter")
		end,
	})

	-- code action UI
	use({
		"jinzhongjia/LspUI.nvim",
		event = "BufReadPost",
		wants = { "nvim-lspconfig" },
		config = function()
			require("plugins.configs.lsp.LspUI")
		end,
	})

	-- debug
	use({
		"mfussenegger/nvim-dap",
		event = "BufReadPost",
		opt = true,
		wants = { "nvim-dap-virtual-text", "nvim-dap-ui" },
		requires = {
			{
				"theHamsta/nvim-dap-virtual-text",
				opt = true,
				config = function()
					require("plugins.configs.debugger.nvim_dap_virtul_text")
				end,
			},
			{
				"rcarriga/nvim-dap-ui",
				opt = true,
				config = function()
					require("plugins.configs.debugger.nvim_dap_ui")
				end,
			},
		},
		config = function()
			require("plugins.configs.debugger.nvim_dap")
		end,
	})

	-- code fold
	use({
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		wants = { "promise-async" },
		requires = { "kevinhwang91/promise-async", opt = true },
		config = function()
			require("plugins.configs.nvim_ufo")
		end,
	})

	-- yank history
	use({
		"gbprod/yanky.nvim",
		event = { "BufReadPost" },
		config = function()
			require("plugins.configs.yanky")
		end,
	})

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		module = { "telescope", "telescope.builtin" },
		keys = { "<leader>f" },
		wants = { "popup.nvim", "plenary.nvim", "nvim-web-devicons", "yanky.nvim", "vim-templates" },
		requires = {
			{ "nvim-lua/popup.nvim", opt = true },
			{ "nvim-lua/plenary.nvim", opt = true },
			{ "kyazdani42/nvim-web-devicons", opt = true },
			{
				"tibabit/vim-templates",
				opt = true,
				cmd = { "TemplateInit", "TemplateExpand" },
				config = function()
					local global = require("core.global")
					vim.g.tmpl_auto_initialize = 0
					vim.g.tmpl_search_paths = { global.vim_config_path .. "/template" }
					vim.g.tmpl_author_name = "ShunLi"
					vim.g.tmpl_author_email = "2015097272@qq.com"
				end,
			},
		},
		config = function()
			require("plugins.configs.telescope")
		end,
	})

	-- special language-based plugins
	use({ "taketwo/vim-ros", ft = { "rosmsg", "cpp" }, cmd = "Roscd" })

	use({ "thibthib18/ros-nvim", ft = { "rosmsg", "cpp" } })

	use({
		"lervag/vimtex",
		ft = "tex",
		config = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.vimtex_mappings_enabled = 0
			vim.g.vimtex_imaps_enabled = 0
			vim.g.vimtex_text_obj_enabled = 1
			vim.g.vimtex_fold_enabled = 1
			vim.g.tex_conceal = "abdmg"
			vim.g.vimtex_format_enabled = 1
		end,
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = ":call mkdp#util#install()",
		ft = { "markdown" },
		config = function()
			vim.cmd([[
            function! g:Open_browser(url)
            silent exec "!google-chrome --password-store=gnome --new-window " . a:url . " &"
            endfunction
            ]])
			vim.g.mkdp_browser = "google-chrome"
			vim.g.mkdp_browserfunc = "g:Open_browser"
		end,
	})

	use({
		"ekickx/clipboard-image.nvim",
		ft = { "markdown" },
		config = function()
			require("plugins.configs.clip_img")
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end

require("packer").startup({
	plug_list_func,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
