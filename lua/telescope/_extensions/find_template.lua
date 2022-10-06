local telescope = require("telescope")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local sorters = require("telescope.sorters")
local conf = require("telescope.config").values

-- the template dir
local conf_dir = require("core.global").vim_config_path
local tmpl_dir = { conf_dir .. "/template" }
local tmpl_full_list = {}
for _, d in pairs(tmpl_dir) do
	local names = vim.fn.readdir(d)
	for _, name in pairs(names) do
        local item = vim.fn.fnamemodify(name, ":r")
		table.insert(tmpl_full_list, {item, d .. "/" .. name })
	end
end

-- prepare the finder
local function apply_template(prompt_bufnr)
	local selection = action_state.get_selected_entry()
    local cmd = 'TemplateInit ' .. selection["display"]
	-- print(cmd)
    vim.cmd(cmd)
    vim.cmd("echom 'hell'")
	actions.close(prompt_bufnr)
end

local find_template = function(opts)
	opts = opts or {}

	pickers
		.new(opts, {
			prompt_title = "find in templates",
			results_title = "templates",
			finder = finders.new_table({
				results = tmpl_full_list,
				entry_maker = function(entry)
					return {
						value = entry[2],
						display = entry[1],
						ordinal = entry[1],
					}
				end,
			}),
			sorter = sorters.get_generic_fuzzy_sorter({}),
			previewer = conf.file_previewer({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(apply_template)
				return true
			end,
		})
		:find()
end

return telescope.register_extension({ exports = { find_template = find_template } })
