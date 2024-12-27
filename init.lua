require("remaps.remap")

require("core.lazy")
require("core.mason")

require("config.dashboard")
require("config.Explorer")
require("config.terminal")
require("config.colors")

-- Set the file format to Unix
vim.opt.fileformat = "unix"

-- Automatically strip trailing carriage returns on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = ":%s/\\r\\+$//e",  -- Use 'e' to suppress errors
})
vim.cmd("colorscheme carbonfox")
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]]) -- Set Neovim to have a transparent background
require("feline").setup({})
