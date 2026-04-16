return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                java = { "google-java-format" }, -- important
                markdown = { "prettier" },
            },

            format_on_save = {
                timeout_ms = 1000,
                lsp_fallback = true, -- if no formatter found
            },
        })

        vim.keymap.set({ "n" }, "<leader>f", function()
            conform.format({
                format_on_save = false,
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end)
    end,
}
--                 null_ls.builtins.formatting.rustfmt,
--                 -- null_ls.builtins.diagnostics.clippy,
--
--                 -- null_ls.builtins.formatting.goimports,
--                 -- null_ls.builtins.formatting.gofumpt,
--
--                 -- Web: HTML, CSS, JS, TS, etc.
--                 null_ls.builtins.formatting.prettier.with({
--                     extra_args = { "--tab-width", "2" },
--                     filetypes = {
--                         "html",
--                         "css",
--                         "javascript",
--                         "javascriptreact",
--                         "typescript",
--                         "typescriptreact",
--                         "json",
--                         "markdown",
--                     },
--                 }),
--                 -- ESLint
--                 -- null_ls.builtins.code_actions.eslint_d,
--
--                 -- Python
--                 null_ls.builtins.formatting.black,
--
--                 -- -- Lua
--                 null_ls.builtins.formatting.stylua,
--
--                 -- C/C++
--                 null_ls.builtins.formatting.clang_format.with({
--                     extra_args = { "--style={IndentWidth: 4, UseTab: Never}" },
--                 }),
--
--                 -- null_ls.builtins.diagnostics.htmlhint,
--                 -- Java
--                 null_ls.builtins.formatting.google_java_format,
--
--                 -- YAML
--                 null_ls.builtins.formatting.yamlfmt,
--                 --sql
--                 -- null_ls.builtins.formatting.sqlfluff,
--                 null_ls.builtins.formatting.pg_format,
--
--                 --bash
--                 null_ls.builtins.formatting.shfmt.with({
--                     extra_args = {
--                         "-i",
--                         "4",
--                         "-ci",
--                         "-sr",
--                     },
--                 }),
--
--                 --xml
--                 null_ls.builtins.formatting.xmllint.with({
--                     command = "sh",
--                     args = {
--                         "-c",
--                         "xmllint --format - | sed -E 's/^( +)/\\1\\1\\1\\1/'",
--                     },
--                 }),
--             },
--         })
