require("yabs"):setup({
	languages = { -- List of languages in vim"s `filetype` format
		cpp = {
			default_task = "build_and_run",
			tasks = {
				build = {
					command = function()
						return "g++ -std=c++11 "
							.. vim.fn.expand("%:t")
							.. " -Wall -ggdb -o "
							.. vim.fn.expand("%:t:r")
							.. ".out"
					end,
					output = "quickfix", -- Where to show output of the
					-- command. Can be `buffer`,
					-- `consolation`, `echo`,
					-- `quickfix`, `terminal`, or `none`
					opts = { -- Options for output (currently, there"s only
						-- `open_on_run`, which defines the behavior
						-- for the quickfix list opening) (can be
						-- `never`, `always`, or `auto`, the default)
						open_on_run = "auto",
					},
				},
				run = { -- You can specify as many tasks as you want per filetype
					command = function()
						return "time ./" .. vim.fn.expand("%:t:r") .. ".out"
					end,
					output = "terminal",
				},
			},
		},
	},
})

vim.api.nvim_set_keymap("n", "rb", ":lua require('yabs'):run_task('build')<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "rr", ":lua require('yabs'):run_task('run')<CR>", { noremap = true })
