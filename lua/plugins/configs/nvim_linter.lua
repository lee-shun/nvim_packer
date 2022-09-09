require("lint").linters_by_ft = {
	markdown = { "markdownlint" },
	cpp = { "cpplint" },
}

local lintCmds = vim.api.nvim_create_augroup("LintCmds", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	callback = function()
		require("lint").try_lint()
	end,
	group = lintCmds,
})
