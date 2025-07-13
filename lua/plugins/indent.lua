return {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl", -- Version 3 uses "ibl" instead of "indent_blankline"
    opts = {
        indent = { char = "│" }, -- Character for vertical lines
        scope = {
            enabled = true, -- Enables block highlighting for functions & loops
            -- show_start = true, -- Show where a block starts
            -- show_end = false, -- Hide where a block ends (optional)
        },
    },
}
