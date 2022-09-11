-- install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	Packer_bootstrap =
		vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

-- plugins

require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })

	-- commom libs
	use({ "nvim-lua/popup.nvim" })

	use({ "nvim-lua/plenary.nvim" })

	-- UI
	use({ "kyazdani42/nvim-web-devicons" })

	use({
		"sainnhe/sonokai",
		config = function()
			vim.g.sonokai_better_performance = 1
			vim.cmd("colorscheme sonokai")
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			{ "kyazdani42/nvim-web-devicons" },
		},
		config = function()
			require("plugins.configs.statusline.eviline")
		end,
	})

	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.configs.alpha")
		end,
	})

	use({
		"RRethy/vim-illuminate",
		event = "BufReadPre",
		config = function()
			require("illuminate").configure({})
		end,
	})

	-- file navgative
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeClose" },
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.configs.nvimtree")
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.configs.telescope")
		end,
	})

	-- general enchance
	use({ "lewis6991/impatient.nvim" })

	use({
		"windwp/nvim-autopairs",
		event = "BufReadPre",
		wants = "nvim-treesitter",
		module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
		config = function()
			require("plugins.configs.autopairs").setup()
		end,
	})

	use({
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		config = function()
			require("Comment").setup({})
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		cmd = "ColorizerToggle",
		config = function()
			require("colorizer").setup({})
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			{ "nvim-treesitter/playground" },
			{ "p00f/nvim-ts-rainbow" },
		},
		config = function()
			require("plugins.configs.treesitter")
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.configs.toggleterm")
		end,
	})

	use({
		"is0n/fm-nvim",
		event = "BufReadPost",
		config = function()
			require("fm-nvim").setup({})
			vim.api.nvim_set_keymap("n", "<Leader>ra", "<cmd>Ranger<CR>", { noremap = true, silent = true })
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
			require("gitsigns").setup({})
		end,
	})

	use({
		"mhartington/formatter.nvim",
		cmd = "Format",
		config = function()
			require("plugins.configs.formatter")
		end,
	})

	use({ "psliwka/vim-smoothie", event = "BufReadPost" })

	use({
		"AckslD/nvim-neoclip.lua",
		event = "BufReadPost",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("neoclip").setup()
			require("telescope").load_extension("neoclip")
		end,
	})

	use({
		"kylechui/nvim-surround",
		event = "BufReadPost",
		config = function()
			require("nvim-surround").setup({})
		end,
	})

	use({ "rlue/vim-barbaric", event = "BufReadPost" })

	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			require("plugins.configs.indent_blankline")
		end,
	})

	use({ "mg979/vim-visual-multi", event = "BufReadPost" })

	use({ "junegunn/vim-easy-align", event = "BufReadPost" })

	use({ "rhysd/conflict-marker.vim", event = "BufReadPost" })

	use({ "tpope/vim-fugitive", cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" } })

	use({ "mbbill/undotree", cmd = "UndotreeToggle " })

	use({
		"anuvyklack/pretty-fold.nvim",
		event = "BufReadPost",
		config = function()
			require("pretty-fold").setup({})
		end,
	})

	use({ "wellle/targets.vim", event = "BufReadPost" })

	use({
		"Pocco81/auto-save.nvim",
		event = "BufReadPost",
		config = function()
			require("auto-save").setup({})
		end,
	})

	use({ "voldikss/vim-translator", cmd = "TranslateW" })

	-- code runner
	use({
		"pianocomposer321/yabs.nvim",
		event = "BufReadPost",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.configs.yabs")
		end,
	})

	-- completion
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		opt = true,
		wants = { "LuaSnip" },
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
				wants = { "friendly-snippets" },
				config = function()
					require("plugins.configs.luasnip").setup()
				end,
			},
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			require("plugins.configs.lsp.cmp")
		end,
	})

    -- lsp
	use({
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		opt = true,
		wants = { "cmp-nvim-lsp", "nvim-semantic-tokens", "aerial.nvim", "inc-rename.nvim" },
		requires = {
			{
				"theHamsta/nvim-semantic-tokens",
				opt = true,
				config = function()
					require("nvim-semantic-tokens").setup({
						preset = "default",
						highlighters = { require("nvim-semantic-tokens.table-highlighter") },
					})
				end,
			},
			{
				"stevearc/aerial.nvim",
				opt = true,
				config = function()
					require("plugins.configs.lsp.aerial")
				end,
			},
			{
				"smjonas/inc-rename.nvim",
				opt = true,
				cmd = "IncRename",
				config = function()
					require("inc_rename").setup()
				end,
			},
		},
		config = function()
			require("plugins.configs.lsp.lspconfig")
		end,
	})

	use({
		"ahmedkhalf/project.nvim",
		event = "BufReadPre",
		config = function()
			require("plugins.configs.lsp.project")
		end,
	})

	use({
		"folke/trouble.nvim",
		event = "BufReadPost",
		cmd = "Trouble",
		config = function()
			require("trouble").setup({})
		end,
	})

	-- linters
	use({
		"mfussenegger/nvim-lint",
		event = "BufReadPre",
		config = function()
			require("plugins.configs.nvim_linter")
		end,
	})

	-- language
	use({ "taketwo/vim-ros", ft = { "rosmsg", "cpp" }, cmd = "Roscd" })

	use({ "thibthib18/ros-nvim", ft = { "rosmsg", "cpp" } })

	use({ "lervag/vimtex", ft = "tex" })

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

	if Packer_bootstrap then
		require("packer").sync()
	end

	pcall(require, "impatient")
end)
