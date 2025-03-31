return {
    "nvimtools/none-ls.nvim", -- Use none-ls instead of null-ls
    event = "VeryLazy",
    opts = function()
        local none_ls = require("null-ls")

        local on_attach = function(client, bufnr)
            if client.server_capabilities.documentFormattingProvider then
                vim.keymap.set("n", "<leader>f", function()
                    vim.lsp.buf.format({ async = true })
                end, { buffer = bufnr, silent = true, desc = "Format Code" })

                -- Auto-format on save for Python
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = true })
                    end,
                })
            else
                print("No formatting support for:", client.name)
            end
        end

        -- Set up formatters and linters
        none_ls.setup({
            sources = {
                none_ls.builtins.code_actions.gitsigns,

                -- Python formatter
                none_ls.builtins.formatting.black,

                -- Lua formatter
                none_ls.builtins.formatting.stylua.with({
                    extra_args = { "--indent-width", "4", "--indent-type", "Spaces" },
                }),

                -- C/C++ formatter
                none_ls.builtins.formatting.clang_format.with({
                    extra_args = { "--style={IndentWidth: 4, UseTab: Never}" },
                }),

                -- Java formatter
                none_ls.builtins.formatting.google_java_format,

                -- JavaScript/TypeScript formatter
                none_ls.builtins.formatting.prettier.with({
                    extra_args = { "--use-tabs=false", "--tab-width=4" },
                }),

                -- JavaScript linter
                -- none_ls.builtins.diagnostics.eslint,

                -- YAML formatter
                none_ls.builtins.formatting.yamlfmt.with({
                    extra_args = { "--indent=4" },
                }),
            },
            on_attach = on_attach,
        })
    end,
}
