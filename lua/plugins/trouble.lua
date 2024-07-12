return {
	{
		"folke/trouble.nvim",
--		lazy = true, -- Enable lazy loading
		cmd = { "TroubleToggle", "Trouble" }, -- Load on specific commands
		config = function()
			require("trouble").setup({
				icons = false, -- Disable icons
				position = "right", -- Sidebar position
				width = 40, -- Width of the sidebar
				auto_open = false, -- Do not automatically open
				auto_close = false, -- Do not automatically close
				use_diagnostic_signs = true, -- Use diagnostic signs
			})

			-- Key mappings
			vim.api.nvim_set_keymap("n", "<leader>tt", ":TroubleToggle<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap(
				"n",
				"[t",
				':lua require("trouble").next({ skip_groups = true, jump = true })<CR>',
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"]t",
				':lua require("trouble").previous({ skip_groups = true, jump = true })<CR>',
				{ noremap = true, silent = true }
			)
		end,
	},
}
