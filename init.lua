require("core.options")
require("core.autocmds")
require("core.functions")
require("core.keymaps")

require("core.lazy")

vim.cmd("syntax enable")
vim.cmd("colorscheme carbonfox")
vim.cmd([[
    hi Normal guibg=NONE ctermbg=NONE
       hi NormalNC guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
]])
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE" })
