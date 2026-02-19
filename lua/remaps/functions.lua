-- local function tmux_buffers()
--     local handle = io.popen("tmux list-windows -F '#I:#W'")
--     if handle == nil then
--         return ""
--     end
--     local result = handle:read("*a")
--     handle:close()
--
--     -- Format the output nicely
--     local windows = {}
--     for line in result:gmatch("[^\r\n]+") do
--         table.insert(windows, line)
--     end
--
--     return table.concat(windows, " | ")
-- end
--
--
--
-- =========================
-- TMUX WINDOWS FUNCTION
-- =========================
local function tmux_buffers()
    local handle = io.popen("tmux list-windows -F '#I:#W' 2>/dev/null")

    if handle == nil then
        return ""
    end

    local result = handle:read("*a")
    handle:close()

    if result == nil or result == "" then
        return ""
    end

    local windows = {}

    for line in result:gmatch("[^\r\n]+") do
        table.insert(windows, line)
    end

    return table.concat(windows, " | ")
end

-- =========================
-- SEPARATOR CHARACTERS
-- =========================
-- These control horizontal and vertical split appearance
vim.opt.fillchars = {
    horiz = "━", -- horizontal split line
    horizup = "━",
    horizdown = "━",

    vert = "┃", -- vertical split line
    vertleft = "┃",
    vertright = "┃",

    verthoriz = "╋", -- intersection
}

-- =========================
-- FORCE SEPARATOR COLOR
-- =========================
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ffffff" })

-- =========================
-- STATUSLINE
-- =========================
-- Left side = file info
-- Right side = tmux windows
vim.opt.statusline = table.concat({
    " ",
    "%f", -- file name
    " ",
    "%m", -- modified flag
    "%=",
    "%{v:lua.tmux_buffers()}",
    " ",
})

-- =========================
-- MAKE FUNCTION GLOBAL
-- =========================
-- Required so statusline can call it
_G.tmux_buffers = tmux_buffers
