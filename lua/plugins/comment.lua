return {

    -- FIXME: fix this broke ass code
    -- BUG: this thing explodes
    -- FIXIT:
    -- FIX: fix this
    -- ISSUE:
    -- TODO: rewrite this garbage
    -- PERF: what is this
    -- OPTIMIZE:
    -- PERFORMANCE:
    -- NOTE: remember to take your meds
    -- HACK: this works but don't ask why
    -- WARNING: nuclear memory leak inside
    -- XXX:
    -- INFO:
    -- PASSED:
    -- TESTING:
    -- FAILED:
    --
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = true,
            sign_priority = 8,

            keywords = {
                FIX = {
                    icon = " ",
                    color = "error",
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = {
                    icon = " ",
                    color = "warning",
                    alt = { "WARNING", "XXX" },
                },
                PERF = {
                    icon = " ",
                    alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
                },
                NOTE = {
                    icon = " ",
                    color = "hint",
                    alt = { "INFO" },
                },
                TEST = {
                    icon = "⏲ ",
                    color = "test",
                    alt = { "TESTING", "PASSED", "FAILED" },
                },
            },

            gui_style = {
                fg = "NONE",
                bg = "BOLD",
            },

            merge_keywords = true,

            highlight = {
                multiline = true,
                multiline_pattern = "^.",
                multiline_context = 10,
                before = "",
                keyword = "wide",
                after = "fg",
                pattern = [[.*<(KEYWORDS)\s*:]],
                comments_only = true,
                max_line_len = 400,
                exclude = {},
            },

            colors = {
                error = { "#DC2626" },
                warning = { "#FBBF24" },
                HACK = { "#FFA500" },
                info = { "#2563EB" },
                hint = { "#10B981" },
                default = { "#7C3AED" },
                test = { "#FF00FF" },
            },

            -- colors = {
            -- 	warning = { "#FBBF24" },
            -- 	error = { "#DC2626" },
            -- 	info = { "#2563EB" },
            -- 	hint = { "#10B981" },
            -- 	test = { "#FF00FF" },
            -- },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                pattern = [[\b(KEYWORDS):]],
            },
        },
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()

            local api = require("Comment.api")
            local map = vim.keymap.set
            local opts = { desc = "Toggle Comment" }

            -- Normal mode
            map("n", "<leader>c", api.toggle.linewise.current, opts)

            -- Visual mode
            map("v", "<leader>c", function()
                local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
                vim.api.nvim_feedkeys(esc, "nx", false)
                api.toggle.linewise(vim.fn.visualmode())
            end, opts)
        end,
    },
}
