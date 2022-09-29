require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true,
	},
	ensure_installed = {"markdown", "cpp", "c", "python", "latex", "lua", "bash"},
})

