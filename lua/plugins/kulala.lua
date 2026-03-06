return {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
        -- default environment
        default_env = "dev",

        -- show pretty formatted response
        formatters = {
            json = { "jq" },
            html = { "prettier", "--parser", "html" },
        },

        -- show response in split window
        display_mode = "split",

        -- don't auto jump to response window
        auto_open_response = true,

        -- syntax highlighting for responses
        winbar = true,

        -- enable environment variables
        environment_scope = "b",

        -- show icons
        icons = {
            inlay = {
                loading = "⏳",
                done = "✓",
                error = "✗",
            },
        },
    },

    keys = {
        {
            "<leader>rr",
            function()
                require("kulala").run()
            end,
            desc = "Run request",
        },
        {
            "<leader>ra",
            function()
                require("kulala").run_all()
            end,
            desc = "Run all requests",
        },
        {
            "<leader>rl",
            function()
                require("kulala").replay()
            end,
            desc = "Replay last request",
        },
        {
            "<leader>rc",
            function()
                require("kulala").copy()
            end,
            desc = "Copy as curl",
        },
        {
            "<leader>ro",
            function()
                require("kulala").open()
            end,
            desc = "Open response",
        },
    },
}
