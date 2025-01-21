vim.opt.termguicolors = true
require("remaps.remap")

require("core.lazy")
require("core.mason")

require("config.dashboard")
require("config.terminal")

vim.opt.clipboard = "unnamedplus"

-- Bind Ctrl+; to normal mode
vim.api.nvim_set_keymap("i", "<C-;>", "<Esc>", { noremap = true, silent = true })

vim.cmd("colorscheme carbonfox")
