return {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Use stable version
    build = "make install_jsregexp", -- Required for regex snippets
    dependencies = {
        "rafamadriz/friendly-snippets", -- Optional: Predefined snippets for multiple languages
    },
    config = function()
        local luasnip = require("luasnip")

        -- Load VSCode-style snippets from friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Load custom Lua snippets from ~/.config/nvim/lua/snippets/
        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })

        -- Optional: Set snippet expansion key (Tab)
        vim.api.nvim_set_keymap(
            "i",
            "<Tab>",
            "<cmd>lua require'luasnip'.jump(1)<CR>",
            { silent = true, noremap = true }
        )
        vim.api.nvim_set_keymap(
            "s",
            "<Tab>",
            "<cmd>lua require'luasnip'.jump(1)<CR>",
            { silent = true, noremap = true }
        )
        vim.api.nvim_set_keymap(
            "i",
            "<S-Tab>",
            "<cmd>lua require'luasnip'.jump(-1)<CR>",
            { silent = true, noremap = true }
        )
        vim.api.nvim_set_keymap(
            "s",
            "<S-Tab>",
            "<cmd>lua require'luasnip'.jump(-1)<CR>",
            { silent = true, noremap = true }
        )
    end,
}
