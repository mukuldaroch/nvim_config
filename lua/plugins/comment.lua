return {
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
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

            -- Visual mode (use Lua function to preserve selection)
            map("v", "<leader>c", function()
                local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
                vim.api.nvim_feedkeys(esc, "nx", false)
                api.toggle.linewise(vim.fn.visualmode())
            end, opts)
        end,
    },
}
