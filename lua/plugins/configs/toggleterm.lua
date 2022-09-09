require("toggleterm").setup({
	direction = "float",
})

vim.api.nvim_set_keymap("n", "<F12>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
