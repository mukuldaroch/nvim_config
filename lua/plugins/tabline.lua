return {
    "nanozuki/tabby.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local theme = {
            fill = "TabLineFill",
            head = "TabLine",
            current_tab = { fg = "#000000", bg = "#35beff", style = "italic" },

            -- vim.api.nvim_set_hl(0, "TabbyRedBG", { bg = "#0000" }),
            vim.api.nvim_set_hl(0, "TabbyRedBG", { bg = "#222222" }),
            tab = "TabLine",
            win = "TabLine",
            tail = "TabLine",
        }

        require("tabby.tabline").set(function(line)
            return {
                vim.cmd([[ highlight TabLineFill guibg=NONE ]]),
                {
                    { "", hl = theme.head },
                },

                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current_tab or theme.tab

                    return {
                        line.sep(" ", "TabbyRedBG", hl),
                        tab.number(),
                        line.sep(" ", "TabbyRedBG", hl),
                        line.sep("", hl, theme.fill),
                        hl = hl,
                    }
                end),
                line.spacer(),
                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current_tab or theme.tab

                    return {
                        -- Left triangle (same as before)
                        line.sep("", hl, theme.fill),

                        -- tab.number(),
                        tab.name(),

                        -- Right triangle: reverse the highlight + fill to color the glyph itself
                        line.sep("", "TabbyRedBG", hl),

                        hl = hl,
                        margin = " ",
                    }
                end),
                -- hl = theme.fill,
            }
        end)
        vim.o.showtabline = 2
    end,
}
