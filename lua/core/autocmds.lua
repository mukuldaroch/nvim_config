-- hides the command line until you need it
-- vim.opt.cmdheight = 0

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        -- enable conceal
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = ""
        -- vim.opt_local.concealcursor = "n"
        -- Visible in insert mode
        -- Hidden in normal mode

        -- set conceal highlight
        vim.api.nvim_set_hl(0, "Conceal", {
            fg = "gray",
        })

        -- Tree-sitter compatible conceal
        vim.cmd([[
            syntax match markdownCodeDelimiter /```/ conceal
        ]])
    end,
})

vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", {
    fg = "#ffffff",
    bg = "#0530a3",
    -- bold = true,
})
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", {
    fg = "#ffffff",
    bg = "#3862d1",
    -- bold = true,
})
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", {
    fg = "#ffffff",
    bg = "#5c75b8",
    -- bold = true,
})
