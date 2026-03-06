return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            char = "│",
            tab_char = "│", -- THIS is the critical line for Go tabs
        },
        whitespace = {
            remove_blankline_trail = false,
        },
        scope = {
            enabled = true, -- Show function/loop boundaries
            show_start = true, -- Highlight the start of the block
            show_end = true, -- Highlight the end of the block
        },
    },
}
