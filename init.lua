-- init.lua

-- Add the path to the plugins file
-- require('plugins')
require("remaps")
require("remaps.remap")

require("core.lazy")
require("core.mason")
require("core.telescope")
require("core.treesitter")

require("plugins")
--require("plugins.autocompletion")
--require("plugins.autopair")
--require("plugins.cloak")
--require("plugins.code_runner")
--require("plugins.dashboard")
--require("plugins.fugitive")
--require("plugins.init.lua")
--require("plugins.lspconfig")
--require("plugins.neo-tree")
--require("plugins.neotest")
--require("plugins.other")
--require("plugins.snippets")
--require("plugins.telescope")
--require("plugins.terminal")
--require("plugins.trouble")
--require("plugins.vimbegood")
--require("plugins.which_key")

-- Example to find syntax errors

require("config.colorscheme")
--require("config.startup")
require("config.dashboard")

require('feline').setup()

