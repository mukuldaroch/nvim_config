-- FORCE SEPARATOR COLOR
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ffffff" })

-- -----------------------------------------------------------
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

-- -----------------------------------------------------------
--
-- vim.cmd([[
--   augroup KillDotRepeat
--     autocmd!
--     autocmd BufEnter * nnoremap <silent> . <Nop>
--   augroup END
-- ]])
