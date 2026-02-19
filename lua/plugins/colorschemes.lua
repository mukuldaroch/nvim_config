return {
    {
        "EdenEast/nightfox.nvim", -- Nightfox theme collection for Neovim
        config = function()
            require("nightfox").setup({
                options = {
                    -- Enable transparency to let terminal background show through Neovim background
                    transparent = true,
                    -- Enable terminal colors to match the theme's colors in Neovim's terminal
                    terminal_colors = false,
                    -- Disable dimming of inactive windows
                    dim_inactive = true,
                    -- Use default values for all modules (treesitter, telescope, etc.)
                    module_default = true,
                    -- Options for colorblind accessibility adjustments
                    colorblind = {
                        enable = false, -- Colorblind mode disabled
                        simulate_only = false, -- Only simulate colorblind view, don't adjust colors
                        severity = {
                            protan = 0, -- Severity for red-blind (protanopia)
                            deutan = 0, -- Severity for green-blind (deuteranopia)
                            tritan = 0, -- Severity for blue-blind (tritanopia)
                        },
                    },
                    -- Style settings for various syntax groups
                    styles = {
                        comments = "italic", -- Make comments italic
                        conditionals = "NONE", -- No specific style for conditionals
                        constants = "NONE", -- No specific style for constants
                        functions = "NONE", -- No specific style for functions
                        keywords = "NONE", -- No specific style for keywords
                        numbers = "NONE", -- No specific style for numbers
                        operators = "NONE", -- No specific style for operators
                        strings = "NONE", -- No specific style for strings
                        types = "NONE", -- No specific style for types
                        variables = "NONE", -- No specific style for variables
                    },

                    -- Options for inverting colors in certain contexts
                    inverse = {
                        match_paren = true, -- Do not invert colors for matching parentheses
                        visual = false, -- Do not invert colors for visual selections
                        search = true, -- Do not invert colors for search matches
                    },

                    -- Configure specific theme modules if needed
                    modules = {}, -- Empty; defaults will be used
                },

                -- Custom color palettes can be defined here (empty, so defaults will be used)
                palettes = {},
                -- Specific color modifications for each theme (empty, so defaults will be used)
                specs = {},
                -- Override highlight groups if needed (empty, so defaults will be used)

                -- groups = {
                --     all = {
                --         WinSeparator = { fg = "#ffffff" }, -- Replace with any color (similar to `flamingo`)
                --
                --     },
                -- },
                groups = {
                    all = {
                        WinSeparator = { fg = "#ffffff" },

                        -- horizontal split line influence
                        StatusLine = { fg = "#ffffff", bg = "NONE" },
                        StatusLineNC = { fg = "#ffffff", bg = "NONE" },

                        -- sometimes used for borders
                        FloatBorder = { fg = "#ffffff" },

                        -- winbar separator (Neovim 0.9+)
                        WinBar = { fg = "#ffffff", bg = "NONE" },
                        WinBarNC = { fg = "#ffffff", bg = "NONE" },
                    },
                },
            })

            -- separator characters
            vim.opt.fillchars = {
                horiz = "━",
                vert = "┃",
                verthoriz = "╋",
            }

            -- force separator color
            vim.api.nvim_set_hl(0, "WinSeparator", {
                fg = "#ffffff",
                bg = "NONE",
            })

            -- CRITICAL FIX: remove statusline background
            vim.api.nvim_set_hl(0, "StatusLine", {
                fg = "#ffffff",
                bg = "NONE",
            })

            vim.api.nvim_set_hl(0, "StatusLineNC", {
                fg = "#777777",
                bg = "NONE",
            })
        end,
    },
}
