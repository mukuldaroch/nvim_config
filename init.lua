vim.opt.termguicolors = true
vim.cmd("syntax enable")

require("core.autocmds")
require("core.functions")
require("core.keymaps")
require("core.options")

require("core.lazy")

vim.cmd("colorscheme carbonfox")

vim.cmd([[
    hi Normal guibg=NONE ctermbg=NONE
       hi NormalNC guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
]])

require("lualine").setup({
    sections = {
        lualine_x = {
            {
                macro_recording,
                color = { fg = "#ff0000", gui = "bold" },
            },
            "branch",
            "diff",
        }, -- Show file encoding, format (e.g., unix), and type
    },
})

-- make floating window background black
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })

-- optional: border color
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7aa2f7", bg = "#000000" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ff0000", bg = "#000000" })
--
