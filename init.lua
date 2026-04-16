vim.opt.termguicolors = true
vim.cmd("syntax enable")

require("core.autocmds")
require("core.functions")
require("core.keymaps")
require("core.options")

require("core.lazy")

vim.cmd("colorscheme carbonfox")
-- Set cmdheight to 1 when macro recording starts
vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        vim.opt.cmdheight = 1
    end,
})

vim.cmd([[
    hi Normal guibg=NONE ctermbg=NONE
       hi NormalNC guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
]])

local function macro_recording()
    local reg = vim.fn.reg_recording()
    if reg == "" then
        return ""
    else
        return " Recording @" .. reg
    end
end
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
vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
