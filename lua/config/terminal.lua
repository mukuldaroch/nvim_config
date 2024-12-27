-- Load the toggleterm plugin
require("toggleterm").setup({})

local Terminal = require("toggleterm.terminal").Terminal

-- Create a cached terminal instance for general use
local general_terminal = Terminal:new({
 cmd = "bash",
 direction = "float",
 float_opts = { border = "none" },
})

-- Function to toggle the general terminal in full screen
function _G.toggle_general_terminal()
 general_terminal.float_opts.width = vim.o.columns
 general_terminal.float_opts.height = vim.o.lines
 general_terminal:toggle()
end

-- Function to open lazygit in a full-screen terminal
function _G.toggle_lazygit()
 local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  float_opts = {
   border = "none",
   width = vim.o.columns,
   height = vim.o.lines,
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
 })
 lazygit:toggle()
end

-- Function to run Python file in a full-screen terminal
function _G.run_python_fullscreen()
 local file = vim.fn.bufname("%")
 local cmd = "py " .. file

 -- Reuse the general terminal for running Python
 general_terminal:on_open(function(term)
  term:send(cmd)
 end)
 general_terminal.float_opts.width = vim.o.columns
 general_terminal.float_opts.height = vim.o.lines
 general_terminal:toggle()
end

-- Function to run Python or C/C++ files in a vertical terminal
function _G.run_code_in_vertical_terminal()
 local extension = vim.fn.expand("%:e")
 local file = vim.fn.bufname("%")
 local cmd

 if extension == "py" then
  --cmd = "clear && py " .. file
  cmd = "py " .. file
 elseif extension == "cpp" then
  cmd = "clear && g++ " .. file .. " && ./a.out"
 elseif extension == "c" then
  cmd = "clear && clang " .. file .. " && ./a.out"
 else
  -- automatically opens the terminal
 end

 local vertical_terminal = Terminal:new({
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
 vertical_terminal:toggle()
end

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>l", ":lua toggle_lazygit()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>c", ":lua toggle_general_terminal()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>i", ":lua run_python_fullscreen()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":lua run_code_in_vertical_terminal()<CR>", { noremap = true, silent = true })
