return {
    -- Load lualine.nvim as a plugin
    "nvim-lualine/lualine.nvim",
    -- Load nvim-web-devicons as a dependency for file icons
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true, -- Enable icons in the statusline
                theme = "auto", -- Automatically detect and apply the theme based on the current colorscheme
                component_separators = { left = "", right = "" }, -- Separators between components
                section_separators = { left = "", right = "" }, -- Separators between sections
                always_divide_middle = true, -- Ensure left and right sections are always separated
                globalstatus = true, -- Use a single statusline for all windows instead of one per window
            },
            sections = {
                -- Left-most section
                lualine_a = { "mode" }, -- Show the current mode (normal, insert, visual, etc.)
                -- Left section next to `lualine_a`
                lualine_b = { { "filetype",color = { fg = "#ffcc66", gui = "bold" } }, "filename" }, -- Show git branch, git diff, and LSP diagnostics
                -- Middle section
                lualine_c = { "diagnostics" }, -- Show the current file name

                -- Right section next to `lualine_z`
                lualine_x = { "branch", "diff" }, -- Show file encoding, format (e.g., unix), and type
                -- Right section before `lualine_z`
                lualine_y = { "progress" }, -- Show the progress in the file (percentage)
                -- Right-most section
                lualine_z = { "location" }, -- Show the current line and column
            },
            inactive_sections = {
                -- Define the statusline for inactive windows (minimal setup)
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" }, -- Show filename only in inactive windows
                lualine_x = { "location" }, -- Show location only in inactive windows
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {}, -- No tabline configuration (can be configured if needed)
            extensions = { "nvim-tree", "quickfix", "fugitive" }, -- Load extensions for tree view, quickfix, and git
        })
    end,
}
