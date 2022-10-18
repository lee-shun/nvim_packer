--
-- buildin Mapping
--
local wk = require("which-key")

-- comp
vim.api.nvim_set_keymap("i", "<CR>", '(pumvisible())?("\\<C-y>"):("\\<cr>")', { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true, noremap = true })

-- quick
local qucik_map = {
	["<leader>"] = { "<Esc>/<++><CR>:nohlsearch<CR>i<Del><Del><Del><Del>", "Search <++> and Change" },
	c = { "<cmd> e ~/.config/nvim/init.lua<CR>", "Edit Personal VIMRC" },
}
local quick_map_opt = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}
wk.register(qucik_map, quick_map_opt)

vim.api.nvim_set_keymap("n", "<C-h>", ":set hlsearch!<CR>", { noremap = true })

-- window
vim.api.nvim_set_keymap("n", "<up>", ":resize +3<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<down>", ":resize -3<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<left>", ":vertical resize-5<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<right>", ":vertical resize+5<CR>", { noremap = true })

-- change indent and select in v-mode
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })

-- add blank line and move line
wk.register({
	["[e"] = { ":<c-u>execute 'move -1-'. v:count1<cr>", "Move Line Prev" },
	["]e"] = { ":<c-u>execute 'move +'. v:count1<cr>", "Move Line Next" },
	["[<leader>"] = { ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[", "Add Empty Line Prev" },
	["]<leader>"] = { ":<c-u>put =repeat(nr2char(10), v:count1)<cr>", "Add Empty Line Next" },
}, {
	mode = "n",
	prefix = "",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

-- yank line
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- greatest remap ever
vim.api.nvim_set_keymap("v", "<leader>p", '"_dP', { noremap = true })

-- move the chosen zone
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

-- place the cursor in the middle
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "J", "mzJ'z", { noremap = true })

-- terminal
vim.api.nvim_set_keymap("t", "<C-N>", "<C-\\><C-N>", { noremap = true })

-- translate
wk.register({
	["ts"] = { ":TranslateW<CR>", "Translate" },
}, {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

-- nvim tree
wk.register({
	["tr"] = { ":NvimTreeToggle<CR>", "NvimTreeToggle" },
}, {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})
