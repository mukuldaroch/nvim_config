local function tmux_buffers()
    local handle = io.popen("tmux list-windows -F '#I:#W'")
    if handle == nil then return "" end
    local result = handle:read("*a")
    handle:close()

    -- Format the output nicely
    local windows = {}
    for line in result:gmatch("[^\r\n]+") do
        table.insert(windows, line)
    end

    return table.concat(windows, " | ")
end
