local cpp_config = {
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
			output = "quickfix",
			opts = { open_on_run = "always" },
		},
		run = {
			command = function()
				return "time ./" .. vim.fn.expand("%:t:r") .. ".out"
			end,
			output = "terminal",
		},
	},
}

require("yabs"):setup({
	languages = {
		cpp = cpp_config,
	},
})


local wk = require("which-key")
local yabs_map_opt = {
	mode = "n",
	prefix = "<leader>r",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

local yabs_map = {
	name = "task runner",
	b = { "<Cmd> lua require('yabs'):run_task('build')<CR>", "build task" },
	r = { "<Cmd> lua require('yabs'):run_task('run')<CR>", "run task" },
}

wk.register(yabs_map, yabs_map_opt)
