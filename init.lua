require("remaps.remap")

require("core.lazy")
require("core.mason")

require("config.dashboard")
require("config.Explorer")
require("config.terminal")

vim.cmd("colorscheme carbonfox")
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]]) -- Set Neovim to have a transparent background
require("feline").setup()
