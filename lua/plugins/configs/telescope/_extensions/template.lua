local scan = require("plenary.scandir")
local strings = require("plenary.strings")
local conf_dir = require("core.global").vim_config_path

local telescope = require("telescope")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local sorters = require("telescope.sorters")
local conf = require("telescope.config").values

local temp_list = scan.scan_dir({ conf_dir .. "/template" }, {
	add_dirs = false,
})

function apply_template(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	print("hello")
	-- local cmd = "TemplateInit " ..
end

local opts = {
	prompt_title = "find in templates",
	results_title = "templates",
	finder = finders.new_table({
		results = temp_list,
	}),
	sorter = sorters.get_generic_fuzzy_sorter({}),
	-- previewer = conf.file_previewer({}),
	attach_mappings = function(prompt_bufnr, map)
		map("i", "CR", apply_template)
		return true
	end,
}

local template_finder = pickers.new(opts)

template_finder:find()

-- local find_template = function(opts)
-- 	opts = opts or {}
-- 	local results = temp_list()
--
-- 	pickers
-- 		.new(opts, {
-- 			prompt_title = "find in templates",
-- 			results_title = "templates",
-- 			finder = finders.new_table({
-- 				results = results,
-- 				entry_maker = make_entry.gen_from_file(opts),
-- 			}),
-- 			previewer = conf.file_previewer(opts),
-- 			sorter = conf.file_sorter(opts),
-- 		})
-- 		:find()
-- end
--
-- return telescope.register_extension({ exports = { find_template = find_template } })
