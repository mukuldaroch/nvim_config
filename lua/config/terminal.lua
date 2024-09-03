-- Load the toggleterm plugin
require("toggleterm").setup({})
local Terminal = require("toggleterm.terminal").Terminal

-- Function to open lazygit in a full-screen terminal
function _lazygit_toggle()
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


-- Terminal for general use
local terminal = Terminal:new({
	cmd = "powershell -nologo",
	direction = "float",
	float_opts = {
		border = "none",
	},
})

-- Function to toggle general terminal
function _G.ToggleTerminal()
	terminal.float_opts.width = vim.o.columns
	terminal.float_opts.height = vim.o.lines
	terminal:toggle()
end

-- function to run python file in terminal
local function run_python_in_full_terminal()
	local file = vim.fn.bufname("%")
	local cmd = "py " .. file
	local run_python = terminal:new({
		cmd = "powershell -nologo",
		direction = "float",
		float_opts = {
			border = "none",
		},
		on_open = function(term)
			term:send(cmd)
		end,
	})

	run_python.float_opts.width = vim.o.columns
	run_python.float_opts.height = vim.o.lines
	run_python:toggle()
end

-- Function to toggle Python terminal with full screen
function _G.toggle_full()
	run_python_in_full_terminal()
end

-- Function to toggle Python terminal vertically
function _G.run_python_in_vertical_terminal()
	local extension = vim.fn.expand("%:e")
	local file = vim.fn.bufname("%")
	if extension == "py" then
		cmd = "py " .. file
	elseif extension == "cpp" then
		cmd = "clang++ " .. file .. "; .\\a.exe"
	elseif extension == "c" then
		cmd = "clang " .. file .. "; .\\a.exe"
	else
		cmd = "powershell -nologo"
	end
	local run_python = Terminal:new({
		cmd = "powershell -nologo",
		direction = "float",
		float_opts = {
			border = "none",
			width = math.floor(vim.o.columns * 0.4),
			height = vim.o.lines,
			col = vim.o.columns - math.floor(vim.o.columns * 0.4),
			row = 0,
		},
		on_open = function(term)
			term:send(cmd)
		end,
	})

	run_python:toggle()
end

function _G.toggle_vertical()
	run_python_in_vertical_terminal()
end
-- Set the leader key
vim.g.mapleader = " "

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>l", ":lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>c", ":lua ToggleTerminal()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>i", ":lua toggle_full()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":lua toggle_vertical()<CR>", { noremap = true, silent = true })
