return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local null_ls = require("null-ls")

        local on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.keymap.set("n", "<leader>f", function()
                    vim.lsp.buf.format({ async = true })
                end, { buffer = bufnr, desc = "Format Code" })
            end
        end

        null_ls.setup({
            sources = {
                -- Web: HTML, CSS, JS, TS, etc.
                null_ls.builtins.formatting.prettier.with({
                    extra_args = { "--tab-width", "4" },
                    filetypes = {
                        "html",
                        "css",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                        "json",
                        "markdown",
                    },
                }),
                -- ESLint
                -- null_ls.builtins.code_actions.eslint_d,

                -- Python
                null_ls.builtins.formatting.black,

                -- Lua
                null_ls.builtins.formatting.stylua,

                -- C/C++
                null_ls.builtins.formatting.clang_format.with({
                    extra_args = { "--style={IndentWidth: 4, UseTab: Never}" },
                }),

                -- null_ls.builtins.diagnostics.htmlhint,
                -- Java
                null_ls.builtins.formatting.google_java_format,

                -- YAML
                null_ls.builtins.formatting.yamlfmt,
                --sql
                -- null_ls.builtins.formatting.sqlfluff,
                null_ls.builtins.formatting.pg_format,

                --bash
                null_ls.builtins.formatting.shfmt,

                --xml
                null_ls.builtins.formatting.xmllint.with({
                    command = "sh",
                    args = {
                        "-c",
                        "xmllint --format - | sed -E 's/^( +)/\\1\\1\\1\\1/'",
                    },
                }),
            },
            on_attach = on_attach,
        })
    end,
}
