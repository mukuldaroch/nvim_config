return {

	{
		"kdheepak/lazygit.nvim",
		config = function()
		end,
	},

	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		},
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = "2",
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "none",
					winblend = 0,
					highlights = {
						border = "none",
						background = "Normal",
					},
					width = function()
						return vim.o.columns
					end,
					height = function()
						return vim.o.lines
					end,
				},
			})

			-- Function to open lazygit in a full screen terminal
			function _lazygit_toggle()
				local Terminal = require("toggleterm.terminal").Terminal
				local lazygit = Terminal:new({
					cmd = "lazygit",
					direction = "float",
					float_opts = {
						border = "none",
						width = function()
							return vim.o.columns
						end,
						height = function()
							return vim.o.lines
						end,
					},
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							"t",
							"<esc>",
							[[<C-\><C-n><cmd>close<CR>]],
							{ noremap = true, silent = true }
						)
					end,
					on_close = function(term)
						vim.cmd("startinsert!")
					end,
				})
				lazygit:toggle()
			end

			vim.g.mapleader = " "
			-- Keybinding to open lazygit
			vim.api.nvim_set_keymap("n", "<leader>g", ":lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })
		end,
	},
	require("telescope").setup({
		defaults = {
			file_ignore_patterns = {
				"%.git/",
				"%.git/*",
				--	"%.gitignore",
			},
		},
		pickers = {},
		extensions = {},
	}),
}
--[[
  {
		"tpope/vim-fugitive",
		lazy = true,
		event = "VeryLazy", -- Load it lazily on a very lazy event
		config = function()
			-- Define a Neovim autocmd group for custom fugitive commands
			local FugitiveGroup = vim.api.nvim_create_augroup("FugitiveGroup", {})

			-- Create an autocmd to set up key mappings for Fugitive buffer
			vim.api.nvim_create_autocmd("BufWinEnter", {
				group = FugitiveGroup,
				pattern = "*",
				callback = function()
					if vim.bo.filetype ~= "fugitive" then
						return
					end

					local bufnr = vim.api.nvim_get_current_buf()
					local opts = { buffer = bufnr, remap = false }

					-- Key mappings for Git commands
					vim.keymap.set("n", "<leader>p", function()
						vim.cmd("Git push")
					end, opts)
					vim.keymap.set("n", "<leader>P", function()
						vim.cmd("Git pull --rebase")
					end, opts)
					vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)

					-- Conflict resolution mappings
					vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", opts)
					vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", opts)
				end,
			})

			-- Key mapping to open the Git status window
			vim.keymap.set("n", "<leader>gs", function()
				vim.cmd("Git")
			end)
		end,
	},
--]]
