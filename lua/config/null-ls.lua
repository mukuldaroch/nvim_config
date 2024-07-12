local null_ls = require("null-ls")

local opts = {
	sources = {
		-- C++ Formatting
		null_ls.builtins.formatting.clang_format,

		-- Python Formatting
		null_ls.builtins.formatting.black,

		-- Lua Formatting
		null_ls.builtins.formatting.stylua,
	},
}

local on_attach = function(client, bufnr)
	-- Formatting
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>f",
			"<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
			{ noremap = true, silent = true }
		)
	end

	-- Diagnostics
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

-- Example LSP configurations
require("lspconfig").pyright.setup({
	on_attach = on_attach,
})

require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
})

return opts
