local null_ls = require("null-ls")
null_ls.setup({
	on_init = function(new_client, _)
		-- new_client.offset_encoding = "utf-32"
	end,
	sources = {
		null_ls.builtins.diagnostics.cpplint,
		-- null_ls.builtins.diagnostics.cspell,
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.pylint,
	},
})
