require("aerial").setup({
	backends = { "lsp", "treesitter", "markdown" },
	filter_kind = {
		"Class",
		"Constructor",
		"Enum",
		"Field",
		"Function",
		"Interface",
		"Module",
        "Namespace",
        "Object",
		"Method",
		"Struct",
		"Property",
		"Variable",
	},
})
