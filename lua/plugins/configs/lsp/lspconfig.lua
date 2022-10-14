-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- semantic provider
	local caps = client.server_capabilities
	if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
		local SemHighlight = vim.api.nvim_create_augroup("SemHighlight", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufEnter", "CursorHold", "InsertLeave", "BufWritePost" }, {
			command = [[lua vim.lsp.buf.semantic_tokens_full()]],
			group = SemHighlight,
			buffer = vim.api.nvim_get_current_buf(),
		})
	end

	-- set highlight
	vim.api.nvim_set_hl(0, "LspProperty", { ctermfg = "LightRed", fg = "LightRed" })

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.keymap.set("n", "<leader>rn", function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, { expr = true })

	-- aerial
	require("aerial").on_attach(client, bufnr)

	-- navic
	local navic = require("nvim-navic")
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
		-- set navic
		vim.o.winbar = "%=%{%v:lua.require'nvim-navic'.get_location()%} "
	end
end

--
-- cmp + lsp
--
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local cmp_cap = require("cmp_nvim_lsp").update_capabilities(capabilities)

local clangd_cap = cmp_cap
clangd_cap.offsetEncoding = { "utf-32" }
-- clangd
require("lspconfig")["clangd"].setup({
	on_attach = on_attach,
	capabilities = clangd_cap,
})

-- local ccls_on_attach = function(client, bufnr)
-- 	vim.cmd([[ hi LspCxxHlGroupMemberVariable ctermfg=LightRed guifg=LightRed  cterm=none gui=none ]])
-- 	on_attach(client, bufnr)
-- end
-- -- ccls
-- require("lspconfig").ccls.setup({
-- 	init_options = {
-- 		highlight = {
-- 			lsRanges = true,
-- 		},
-- 	},
-- 	on_attach = ccls_on_attach,
-- 	capabilities = cmp_cap,
-- })

-- pyright
require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	capabilities = cmp_cap,
})

-- taxlab
require("lspconfig")["texlab"].setup({
	on_attach = on_attach,
	capabilities = cmp_cap,
})

-- lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig")["sumneko_lua"].setup({
	on_attach = on_attach,
	capabilities = cmp_cap,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- set icons (if not use lsp-saga)
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
