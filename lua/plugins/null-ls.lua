return {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
        local on_attach = function(client, bufnr)
            if client.server_capabilities.documentFormattingProvider then
                vim.keymap.set("n", "<leader>f", function()
                    vim.lsp.buf.format({ async = true })
                end, { buffer = bufnr, silent = true, desc = "Format Code" })
            else
                print("No formatting support for:", client.name)
            end
        end

        -- Setup LSP servers with on_attach
        local lspconfig = require("lspconfig")
        local servers = { "pyright", "lua_ls", "clangd", "jdtls" }
        for _, server in ipairs(servers) do
            lspconfig[server].setup({ on_attach = on_attach })
        end

        -- Setup null-ls for formatters and enforce spaces instead of tabs
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                require("null-ls").builtins.code_actions.gitsigns,
                -- Python: Use black (always uses spaces)
                null_ls.builtins.formatting.black,

                -- Lua: stylua with enforced spaces
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--indent-width", "4", "--indent-type", "Spaces" },
                }),

                -- C/C++: clang-format with enforced spaces
                null_ls.builtins.formatting.clang_format.with({
                    extra_args = { "--style={IndentWidth: 4, UseTab: Never}" },
                }),

                -- Java: google-java-format (always uses spaces)
                null_ls.builtins.formatting.google_java_format,

                -- JavaScript/TypeScript: prettier with enforced spaces
                null_ls.builtins.formatting.prettier.with({
                    extra_args = { "--use-tabs=false", "--tab-width=4" },
                }),

                -- JSON/YAML: prettier (JSON) and yamlfmt (YAML) with spaces
                null_ls.builtins.formatting.prettier.with({
                    extra_args = { "--use-tabs=false", "--tab-width=4" },
                }),
                null_ls.builtins.formatting.yamlfmt.with({
                    extra_args = { "--indent=4" },
                }),
            },
            on_attach = on_attach,
        })

        -- Auto-format Python files on save
        vim.cmd([[autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = true })]])
    end,
}
