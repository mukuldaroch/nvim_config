vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.java",
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Set cmdheight to 1 when macro recording starts
vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        vim.opt.cmdheight = 1
    end,
})

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

--------------------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function() -- Set the color for concealed text
        vim.cmd("highlight Conceal ctermfg=gray guifg=gray") -- Match ``` and conceal it
        vim.cmd("syntax match markdownCodeDelimiter /```/ conceal") -- Ensure conceal is enabled
    end,
})

-- vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", {
-- 	fg = "#000000",
-- 	bg = "#10B981",
-- 	-- bold = true,
-- })
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


-- Force separator characters to be visible
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ffffff", bg = "NONE" })

-- These control horizontal split visibility
vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#888888", bg = "NONE" })
