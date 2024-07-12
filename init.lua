
-- plenary 
-- init.lua
-- Add the path to the plugins file
-- require('plugins')
require("remaps")
require("remaps.remap")
require("remaps.plugins")

require("core.lazy")
require("core.mason")

--require("plugins.autopair")
require("plugins.alpha_dashboard")
--require("plugins.cloak")
require("plugins.debugger")
--require("plugins.fugitive")
require("plugins.Git")
require("plugins.lspconfig")
require("plugins.colorschemes")
require("plugins.snippets")
require("plugins.telescope")
require("plugins.treesitter")
--require("plugins.trouble")
require("plugins.vimbegood")

-- Example to find syntax errors

require("config.colorscheme")
--require("config.startup")
require("config.dashboard")
--require("config.nvim_tree")
require("config.Explorer")


require('feline').setup()
