-- Define a single on_attach function
local on_attach = function(client, bufnr)
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
		print("No formatting support for:", client.name)
	end

	-- Diagnostic keymaps
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

-- Setup LSP servers
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.clangd.setup({ on_attach = on_attach })

-- Setup null-ls for additional formatters and linters
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.stylua,
		-- Uncomment these if needed for linting or diagnostics
		-- null_ls.builtins.diagnostics.mypy,
		-- null_ls.builtins.diagnostics.ruff,
	},
	on_attach = function(client, bufnr)
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
-- Use black as the default Python formatter
vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = true })]]

