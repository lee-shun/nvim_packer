-- install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	Packer_bootstrap =
		vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

-- plugins

require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })

	use({
		"sainnhe/sonokai",
		config = function()
			vim.g.sonokai_better_performance = 1
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
		requires = {
			{ "kyazdani42/nvim-web-devicons", opt = true },
		},
		config = function()
			require("plugins.configs.eviline")
		end,
	})

	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
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

	-- general enchance
	use({ "lewis6991/impatient.nvim" })

	use({
		"echasnovski/mini.nvim",
		branch = "stable",
		event = "BufReadPost",
		config = function()
			require("mini.trailspace").setup({})
		end,
	})

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
		wants = "nvim-treesitter",
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
		wants = { "playground", "nvim-ts-rainbow" },
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
		event = "BufReadPre",
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

	use({ "junegunn/vim-easy-align", event = "BufReadPost" })

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
		event = { "BufReadPre", "BufNewFile" },
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
		"kosayoda/nvim-lightbulb",
		event = "BufReadPost",
		wants = { "FixCursorHold.nvim" },
		requires = {
			{ "antoinemadec/FixCursorHold.nvim", opt = true },
		},
		config = function()
			require("nvim-lightbulb").setup({
				sign = { enabled = false },
				float = {
					enabled = true,
				},
				autocmd = {
					enabled = true,
				},
			})
		end,
	})

	-- debug
	use({
		"mfussenegger/nvim-dap",
		event = "BufReadPost",
		opt = true,
		requires = {
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("plugins.configs.debugger.nvim_dap_virtul_text")
				end,
			},
			{
				"rcarriga/nvim-dap-ui",
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
		requires = { "kevinhwang91/promise-async", opt = 1 },
		config = function()
			require("plugins.configs.nvim_ufo")
		end,
	})

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		module = { "telescope", "telescope.builtin" },
		keys = { "<leader>f" },
		wants = { "plenary.nvim", "popup.nvim", "nvim-web-devicons", "yanky.nvim", "vim-templates" },
		requires = {
			{ "nvim-lua/popup.nvim", opt = true },
			{ "nvim-lua/plenary.nvim", opt = true },
			{ "kyazdani42/nvim-web-devicons", opt = true },
			{
				"gbprod/yanky.nvim",
				opt = true,
				config = function()
					require("plugins.configs.yanky")
				end,
			},
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

	use({
		"ekickx/clipboard-image.nvim",
		ft = { "markdown" },
		config = function()
			require("plugins.configs.clip_img")
		end,
	})

	use({
		"jbyuki/nabla.nvim",
		ft = { "markdown", "tex" },
		config = function()
			local nabulaDis = vim.api.nvim_create_augroup("NabulaDis", { clear = true })
			vim.api.nvim_create_autocmd({ "CursorHold", "Filetype" }, {
				pattern = { "markdown", "tex" },
				command = [[silent! lua require("nabla").popup({ border = "rounded" })]],
				group = nabulaDis,
			})
			vim.cmd([[au CursorHold *.md,*.markdown silent! lua require("nabla").popup({ border = "rounded" })]])
		end,
	})

	use({
		"NFrid/due.nvim",
		ft = "markdown",
		config = function()
			require("due_nvim").setup({})
		end,
	})

	if Packer_bootstrap then
		require("packer").sync()
	end

	pcall(require, "impatient")
end)
