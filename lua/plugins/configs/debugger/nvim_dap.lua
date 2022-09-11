-- show the winbar
local dapWinbar = vim.api.nvim_create_augroup("DapWinbar", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "dap*" },
	command = "setlocal winbar=%f",
	group = dapWinbar,
})

--
-- keymaps
--
vim.api.nvim_set_keymap("n", "<leader>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>dB",
	"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>dc", "<Cmd>lua require'dap'.continue()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ds", "<Cmd>lua require'dap'.close()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>di", "<Cmd>lua require'dap'.step_into()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dv", "<Cmd>lua require'dap'.step_over()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>du", "<Cmd>lua require'dap'.step_out()<CR>", { noremap = true })

local dap = require("dap")
--
-- cpp
--

-- adapter
dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "/home/ls/.language_tools/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7",
}

-- gdb
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
	},
}

--
-- c
--
dap.configurations.c = dap.configurations.cpp

--
-- python
--
