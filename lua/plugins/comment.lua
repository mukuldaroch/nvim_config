return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()

        -- Custom keybindings with <leader>c
        local api = require("Comment.api")
        vim.keymap.set("n", "<leader>c", api.toggle.linewise.current, { desc = "Toggle Comment" })
        vim.keymap.set(
            "v",
            "<leader>c",
            "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            { desc = "Toggle Comment in Visual Mode" }
        )
    end,
}
