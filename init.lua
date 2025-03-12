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
vim.cmd([[
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
]])
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end
