return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- Configure nvim-treesitter
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "vim", "vimdoc" },
                -- working parsers = c , lua , python,
                -- not working parsers = cpp
                auto_install = true,
                -- indent = {
                -- 	enable = true,
                -- },

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true, -- Disable legacy Vim highlighting
                },
            })
        end,
    },
}
