local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.cpplint,
		null_ls.builtins.diagnostics.markdownlint_cli2,
		null_ls.builtins.diagnostics.pylint,
	},
})
