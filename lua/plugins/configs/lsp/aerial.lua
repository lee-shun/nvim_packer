require("aerial").setup({
	backends = { "lsp", "treesitter", "markdown" },
	filter_kind = {
		"Class",
		"Constructor",
		"Enum",
		"Function",
		"Interface",
		"Module",
		"Method",
		"Struct",
		"Property",
		"Variable",
	},
})
