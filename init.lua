require("remaps.remap")
--require("remaps.plugins")

require("core.lazy")
require("core.mason")

--require("plugins.debugger")
--require("plugins.lazy")
--require("plugins.Git")
--require("plugins.lspconfig")
--require("plugins.colorschemes")
--require("plugins.snippets")
--require("plugins.telescope")
--require("plugins.treesitter")
--require("plugins.vimbegood")
--require("plugins.terminal")
--[[
hy gpt is got what the problem is so i use lazy.nvim and after the update there is a bug appeared that it automatically loads all the plugins at once so if i open nvim by command nvim 		file = vim.fn.bufname("%")
this gives null value because at the time vim is opened no buffer was active and if i open nvim by command nvim filename.py 		file = vim.fn.bufname("%")
it returns filename.py but if i change the current buffer by telescope.nvim to secoundfile.py 		file = vim.fn.bufname("%")
it still return the filename.py because 		file = vim.fn.bufname("%")
in file variable it is stored for a session i want it to return the currnt opend buffer name but lazy.nvim removed or i dont know it disabled lazyloading before the update i used to call the plugin only when i needed using require(plugin.name) so that the plugin can only run when it is called and 		file = vim.fn.bufname("%")
returns the name of currently opened buffer name help me 
--]]
require("config.dashboard")
require("config.Explorer")
require("config.terminal")

vim.cmd("colorscheme carbonfox")
require("feline").setup()
