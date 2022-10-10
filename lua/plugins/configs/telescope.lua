local present, telescope = pcall(require, "telescope")
if not present then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "   ",
		selection_caret = " ",
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
			},
		},
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	},
})

-- extensions
require("telescope").load_extension("yank_history")
require("telescope").load_extension("find_template")

local wk = require("which-key")
local tel_map_opt = {
	mode = "n",
	prefix = "<leader>f",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

local tel_map = {
	name = "find",
	f = { "<Cmd> Telescope find_files<CR>", "find file" },
	b = { "<Cmd> Telescope buffers<CR>", "find buffers" },
	m = { "<Cmd> Telescope oldfiles<CR>", "find most recent files" },
	w = { "<Cmd> Telescope live_grep<CR>", "find word" },
	l = { "<Cmd> Telescope current_buffer_fuzzy_find<CR>", "find line in current buffer" },
	r = { "<Cmd> Telescope registers<CR>", "find registers" },
	d = { "<Cmd> Telescope diagnostics<CR>", "find diagnostics" },
	j = { "<Cmd> Telescope jumplist<CR>", "find jumplist" },
	y = { "<Cmd> Telescope yank_history<CR>", "find yank history" },
	t = { "<Cmd> Telescope find_template<CR>", "find file templates" },
}

wk.register(tel_map, tel_map_opt)
