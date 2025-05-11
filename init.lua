vim.opt.termguicolors = true
vim.cmd("syntax enable")

require("remaps.remap")

require("core.lazy")
require("core.mason")

vim.cmd("colorscheme carbonfox")

-- Your custom scroll mappings
vim.keymap.set("n", "<C-u>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-i>", "<C-u>zz", { noremap = true, silent = true })

-- Remap jump back/forward to Ctrl-9 and Ctrl-0
vim.keymap.set("n", "<C-,>", "<C-o>", { noremap = true, silent = true }) -- jump back
vim.keymap.set("n", "<C-.>", "<C-i>", { noremap = true, silent = true }) -- jump forward

-- Bind Ctrl+; to normal mode
vim.keymap.set("i", "<C-;>", "<Esc>", { noremap = true, silent = true })

vim.g.mapleader = " " -- Set leader key to space (change if needed)
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h", ":split<CR>", { noremap = true, silent = true })

local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

vim.cmd([[
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
]])
