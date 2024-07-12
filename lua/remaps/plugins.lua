
-- remaps/plugins.lua

-- Define a local table to hold the configuration
local M = {}

-- Define the DAP mappings
M.dap = {
    plugin = true, -- Indicates that this is related to a plugin
    n = {          -- Normal mode mappings
        ["<leader>db"] = {
            "<cmd> DapToggleBreakpoint <CR>",
            "start breakpoint at line", -- Description for the mapping
        },
        ["<leader>dr"] = {
            "<cmd> DapContinue <CR>",   -- Corrected the command from DapConitnue to DapContinue
            "start or continue the debugger", -- Description for the mapping
        },
    }
}

-- Return the configuration table
return M

