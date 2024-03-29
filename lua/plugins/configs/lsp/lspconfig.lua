local wk = require("which-key")

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- navic
	local navic = require("nvim-navic")
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
		-- set navic
		vim.o.winbar = "%=%{%v:lua.require'nvim-navic'.get_location()%} "
	end

	-- mappings
	local keymap_g = {
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
		H = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
		h = { "<cmd>LspUI hover<CR>", "LspUI Hover" },
		i = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
		t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
		r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto Reference" },
	}
	wk.register(keymap_g, {
		mode = "n",
		prefix = "g",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})

	-- diagnostic
	local keymap_l = {
		l = {
			name = "LSP",
			a = { "<cmd>LspUI code_action<CR>", "LspUI Code Action" },
			d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic Float" },
			i = {
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				"IncRename",
				expr = true,
			},
			r = { "<cmd>LspUI rename<CR>", "LspUI Rename" },
		},
	}
	wk.register(keymap_l, {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})

	wk.register({
		["[d"] = { "<cmd>LspUI diagnostic prev<CR>", "LspUI Prev Diagnostic" },
		["]d"] = { "<cmd>LspUI diagnostic next<CR>", "LspUI Next Diagnostic" },
	}, {
		mode = "n",
		prefix = "",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})
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

local cmp_cap = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- clangd
local clangd_cap = cmp_cap
clangd_cap.offsetEncoding = { "utf-16" }
local clangd_on_attach = function(client, bufnr)
	local keymap_l = {
		l = {
			name = "LSP",
			j = { "<cmd> ClangdSwitchSourceHeader<CR>", "Clangd Switch Header" },
		},
	}
	wk.register(keymap_l, {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})

	return on_attach(client, bufnr)
end
require("lspconfig")["clangd"].setup({
	on_attach = clangd_on_attach,
	capabilities = clangd_cap,
})

-- cmake
require("lspconfig")["cmake"].setup({
	on_attach = on_attach,
	capabilities = cmp_cap,
})

-- pyright
local pyright_cap = cmp_cap
require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	capabilities = pyright_cap,
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

require("lspconfig")["lua_ls"].setup({
	on_attach = on_attach,
	capabilities = cmp_cap,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
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

-- set icons (if not use lspsaga)
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
