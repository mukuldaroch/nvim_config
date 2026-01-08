vim.opt.termguicolors = true
vim.cmd("syntax enable")

require("remaps.remap")

require("core.lazy")
require("core.mason")

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

-- Hide cmdline when recording starts
vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        -- Delay slightly to override Neovim's default behavior
        local timer = vim.loop.new_timer()
        timer:start(
            50,
            0,
            vim.schedule_wrap(function()
                vim.opt.cmdheight = 0
            end)
        )
    end,
})

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
