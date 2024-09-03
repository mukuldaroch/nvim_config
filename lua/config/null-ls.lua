local on_attach = function(client, bufnr)
	
	if client.server_capabilities.documentFormattingProvider or client.name == "null-ls" then
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>f",
			"<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
			{ noremap = true, silent = true }
		)
	else
		print("No formatting support for:", client.name)
	end

	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>e",
		"<cmd>lua vim.diagnostic.open_float()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"[d",
		"<cmd>lua vim.diagnostic.goto_prev()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"]d",
		"<cmd>lua vim.diagnostic.goto_next()<CR>",
		{ noremap = true, silent = true }
	)
end

local lspconfig = require("lspconfig")

lspconfig.pyright.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.clangd.setup({ on_attach = on_attach })

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.stylua,
		--null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.diagnostics.ruff,
	},

	on_attach = function(client, bufnr)
		-- Enable formatting keymap if the client supports it
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_buf_set_keymap(
				bufnr,
				"n",
				"<leader>f",
				"<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
				{ noremap = true, silent = true }
			)
		else
			print("null-ls does not support documentFormattingProvider:", client.name)
		end
	end,
})

local on_attach = function(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>f",
			"<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
			{ noremap = true, silent = true }
		)
	else
		print("LSP server does not support documentFormattingProvider:", client.name)
	end
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>dia",
		"<cmd>lua vim.diagnostic.open_float()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>[d",
		"<cmd>lua vim.diagnostic.goto_prev()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>]d",
		"<cmd>lua vim.diagnostic.goto_next()<CR>",
		{ noremap = true, silent = true }
	)
end

local lspconfig = require("lspconfig")
lspconfig.black.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.clangd.setup({ on_attach = on_attach })
