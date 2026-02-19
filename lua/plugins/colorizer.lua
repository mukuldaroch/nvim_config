return {
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                "*", -- Highlight all file types
            }, {
                RGB = true, -- Enable #RGB hex colors
                RRGGBB = true, -- Enable #RRGGBB hex colors
                RRGGBBAA = true, -- Enable #RRGGBBAA hex colors
                rgb_fn = true, -- Enable CSS rgb functions
                hsl_fn = true, -- Enable CSS hsl functions
            })
        end,
    },
}
