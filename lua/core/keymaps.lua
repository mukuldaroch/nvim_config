--
-- CTRL + j → next tab
vim.keymap.set("n", "<C-j>", function()
    vim.cmd("tabnext")
end, { desc = "Next Tab" })

-- CTRL + k → previous tab
vim.keymap.set("n", "<C-k>", function()
    vim.cmd("tabprevious")
end, { desc = "Previous Tab" })

-- CTRL + t → new tab
vim.keymap.set("n", "<C-t>", function()
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)

    if file ~= "" then
        -- Open same file in a new tab
        vim.cmd("tabnew " .. file)
    else
        -- If buffer has no name, just open empty tab
        vim.cmd("tabnew")
    end
end, { desc = "New tab with same file" })

-- CTRL + w → close tab (NOT window)
vim.keymap.set("n", "<C-w>", function()
    vim.cmd("tabclose")
end, { desc = "Close Tab" })

vim.keymap.set("n", "<C-,>", "<C-o>", { noremap = true, silent = true }) -- jump back
vim.keymap.set("n", "<C-.>", "<C-i>", { noremap = true, silent = true }) -- jump forward

-- Bind Ctrl+; to normal mode
vim.keymap.set("i", "<C-;>", "<Esc>", { noremap = true, silent = true })

vim.g.mapleader = " " -- Set leader key to space (change if needed)
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>hs", ":split<CR>", { noremap = true, silent = true })
-- -- Resize splits like tmux
-- vim.keymap.set("n", "<leader>.", ":vertical resize -5<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>,", ":vertical resize +5<CR>", { silent = true })

-- Resize mode
-- Resize mode with timeout
local function start_resize_mode()
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { noremap = true, silent = true, buffer = bufnr }

    local timeout_ms = 800
    local timer = nil

    local function cleanup()
        if timer then
            timer:stop()
            timer:close()
            timer = nil
        end
        pcall(vim.keymap.del, "n", ",", { buffer = bufnr })
        pcall(vim.keymap.del, "n", ".", { buffer = bufnr })
        pcall(vim.keymap.del, "n", "q", { buffer = bufnr })
        pcall(vim.keymap.del, "n", "<Esc>", { buffer = bufnr })
    end

    local function reset_timer()
        if timer then
            timer:stop()
            timer:close()
        end
        timer = vim.loop.new_timer()
        timer:start(timeout_ms, 0, vim.schedule_wrap(cleanup))
    end

    vim.keymap.set("n", ",", function()
        vim.cmd("vertical resize +5")
        reset_timer()
    end, opts)

    vim.keymap.set("n", ".", function()
        vim.cmd("vertical resize -5")
        reset_timer()
    end, opts)

    vim.keymap.set("n", "q", cleanup, opts)
    vim.keymap.set("n", "<Esc>", cleanup, opts)

    reset_timer()
end

-- Entry points (tmux-style)
vim.keymap.set("n", "<leader>,", function()
    vim.cmd("vertical resize +5")
    start_resize_mode()
end, { silent = true })

vim.keymap.set("n", "<leader>.", function()
    vim.cmd("vertical resize -5")
    start_resize_mode()
end, { silent = true })

--------------------------------------------------------------------------------------------------------
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
---
vim.g.mapleader = " "

vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- ---------------------------------------------------------------------------------------------------------------------
local map = vim.keymap.set

-- Insert mode key mappings
map("i", "<C-i>", "<ESC>^i", { desc = "move to beginning of line" }) -- Move to the start of the line
map("i", "<C-a>", "<End>", { desc = "move to end of line" }) -- Move to the end of the line
map("i", "<C-h>", "<Left>", { desc = "move left" }) -- Move cursor left
map("i", "<C-l>", "<Right>", { desc = "move right" }) -- Move cursor right

-- Normal mode key mappings
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "clear highlights" }) -- Clear search highlights

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" }) -- Switch to left window
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" }) -- Switch to right window

map("n", "<C-s>", "<cmd>w<CR>", { desc = "save file" }) -- Save file
-- ---------------------------------------------------------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true }) -- to move to the split on the left
-- vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true }) -- to move to the split below
-- vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true }) -- to move to the split above
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true }) -- to move to the split on the right
-- ---------------------------------------------------------------------------------------------------------------------
-- Key mapping for :q (quit)
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
-- Key mapping for :q! (force quit)
vim.keymap.set("n", "<leader>qq", ":q!<CR>", { noremap = true, silent = true })
-- Key mapping for :w (save)
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { noremap = true, silent = true })
-- ---------------------------------------------------------------------------------------------------------------------

vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover({ border = "rounded" })
end)
