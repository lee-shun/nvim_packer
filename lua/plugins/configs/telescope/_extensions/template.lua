local telescope = require("telescope")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local sorters = require("telescope.sorters")
local entry_display = require("telescope.pickers.entry_display")
local conf = require("telescope.config").values

local template = {}

-- the template dir
local conf_dir = require("core.global").vim_config_path
local tmpl_dir = { conf_dir .. "/template" }
local tmpl_full_list = {}
for _, d in pairs(tmpl_dir) do
	local names = vim.fn.readdir(d)
	for _, name in pairs(names) do
		table.insert(tmpl_full_list, {name, d .. "/" .. name})
	end
end

-- prepare the finder
function template.apply_template(prompt_bufnr)
	actions.close(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	print(vim.inspect(selection))
end

local opts = {
	prompt_title = "find in templates",
	results_title = "templates",
	finder = finders.new_table({
		results = tmpl_full_list,
		entry_maker = function(entry)
			return {
				value = entry,
				display = entry[1],
				ordinal = entry[1],
			}
		end,
	}),
	sorter = sorters.get_generic_fuzzy_sorter({}),
	previewer = conf.file_previewer({
        get_command = function (entry, status)
            return {'bat', entry.value}
        end
    }),
	attach_mappings = function(prompt_bufnr, map)
		actions.select_default:replace(template.apply_template)
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
