vim.opt.termguicolors = true
vim.cmd("syntax enable")

require("remaps.remap")

require("core.lazy")
require("core.mason")

vim.opt.clipboard = "unnamedplus"

vim.cmd("colorscheme carbonfox")

vim.api.nvim_create_autocmd("LspDetach", {
    pattern = "*",
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "clangd" then
            vim.defer_fn(function()
                print("Restarting clangd...")
                vim.cmd("LspStart clangd")
            end, 100) -- Restart after 100ms
        end
    end,
})

-- Bind Ctrl+; to normal mode
vim.keymap.set("i", "<C-;>", "<Esc>", { noremap = true, silent = true })

vim.g.mapleader = " " -- Set leader key to space (change if needed)
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>hs", ":split<CR>", { noremap = true, silent = true })


vim.cmd([[highlight WinSeparator guifg=#555555 guibg=None]]) -- Change #555555 to a color you prefer
vim.o.fillchars = "vert:│,horiz:─" -- Thin lines for vertical and horizontal splits
vim.opt.fillchars = {
    vert = "│",  -- Thin vertical separator
    horiz = "─", -- Thin horizontal separator
    horizup = "─",
    horizdown = "─",
    vertleft = "│",
    vertright = "│",
    verthoriz = "┼",
}

vim.cmd([[
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
]])
