-- -- Your custom scroll mappings
-- vim.keymap.set("n", "<C-u>", "<C-d>zz", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-i>", "<C-u>zz", { noremap = true, silent = true })
--
-- -- Remap jump back/forward to Ctrl-9 and Ctrl-0
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

--------------------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function() -- Set the color for concealed text
        vim.cmd("highlight Conceal ctermfg=gray guifg=gray") -- Match ``` and conceal it
        vim.cmd("syntax match markdownCodeDelimiter /```/ conceal") -- Ensure conceal is enabled
        vim.opt.conceallevel = 2
    end,
})

--   fg = "#FF4500",

-- vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", {
-- 	fg = "#000000",
-- 	bg = "#10B981",
-- 	-- bold = true,
-- })
vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", {
    fg = "#ffffff",
    bg = "#0530a3",
    -- bold = true,
})
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", {
    fg = "#ffffff",
    bg = "#3862d1",
    -- bold = true,
})
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", {
    fg = "#ffffff",
    bg = "#5c75b8",
    -- bold = true,
})
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
vim.g.mapleader = " "

vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
-- vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- ---------------------------------------------------------------------------------------------------------------------
-- Ensure the leader key is set

local map = vim.keymap.set

-- Insert mode key mappings
map("i", "<C-b>", "<ESC>^i", { desc = "move to beginning of line" }) -- Move to the start of the line
map("i", "<C-e>", "<End>", { desc = "move to end of line" }) -- Move to the end of the line
map("i", "<C-h>", "<Left>", { desc = "move left" }) -- Move cursor left
map("i", "<C-l>", "<Right>", { desc = "move right" }) -- Move cursor right
map("i", "<C-j>", "<Down>", { desc = "move down" }) -- Move cursor down
map("i", "<C-k>", "<Up>", { desc = "move up" }) -- Move cursor up

-- Normal mode key mappings
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "clear highlights" }) -- Clear search highlights

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" }) -- Switch to left window
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" }) -- Switch to right window
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" }) -- Switch to window below
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" }) -- Switch to window above

map("n", "<C-s>", "<cmd>w<CR>", { desc = "save file" }) -- Save file
-- ---------------------------------------------------------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true }) -- to move to the split on the left
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true }) -- to move to the split below
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true }) -- to move to the split above
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true }) -- to move to the split on the right
-- ---------------------------------------------------------------------------------------------------------------------
-- Key mapping for :q (quit)
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
-- Key mapping for :q! (force quit)
vim.keymap.set("n", "<leader>qq", ":q!<CR>", { noremap = true, silent = true })
-- Key mapping for :w (save)
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
-- ---------------------------------------------------------------------------------------------------------------------
-- hides the command line until you need it
vim.opt.cmdheight = 0
-- ---------------------------------------------------------------------------------------------------------------------
-- vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { noremap = true, silent = true })
