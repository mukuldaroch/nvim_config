return {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",

    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        --
        -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
        { "williamboman/mason.nvim", opts = {} },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        --{ "j-hui/fidget.nvim", opts = {} },

        { "j-hui/fidget.nvim", opts = {} },

        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        -- { "folke/neodev.nvim", opts = {} },
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                -- Find references for the word under your cursor.
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                -- map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                -- Opens a popup that displays documentation about the word under your cursor
                --  See `:help K` for why this keymap.
                map("K", vim.lsp.buf.hover, "Hover Documentation")

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({
                                group = "kickstart-lsp-highlight",
                                buffer = event2.buf,
                            })
                        end,
                    })
                end

                -- The following autocommand is used to enable inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
                if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local lspconfig = require("lspconfig")

        lspconfig.clangd.setup({
            cmd = {
                "clangd",
                "--background-index",
                "--suggest-missing-includes",
                "--compile-commands-dir=.",
            },
            capabilities = {
                offsetEncoding = { "utf-8" }, -- helps with some LSP encoding issues
            },
            root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"), -- better project root detection
            filetypes = { "h", "c", "cpp", "objc", "objcpp" },
            single_file_support = true,
        })

        require("lspconfig").lua_ls.setup({
            cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" }, -- Use Mason's LSP
            capabilities = {
                offsetEncoding = "utf-8",
            },
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                    },
                    -- diagnostics = {
                    --     globals = { "vim" }, -- Tell LSP that `vim` is a global variable
                    -- },
                },
            },
        })

        require("lspconfig").marksman.setup({
            cmd = { vim.fn.stdpath("data") .. "/mason/bin/marksman" }, -- or just "marksman" if it's globally installed
            filetypes = { "markdown", "markdown.mdx" },
            capabilities = {
                offsetEncoding = "utf-8",
            },
        })
        require("lspconfig").jdtls.setup({
            cmd = { "jdtls" },
            root_dir = require("lspconfig").util.root_pattern(".git", "pom.xml", "build.gradle"),
            capabilities = {
                -- Add any additional capabilities if needed
                offsetEncoding = "utf-8",
            },
            filetypes = { "java" },
            single_file_support = true,
            settings = {
                java = {
                    -- Specify additional configurations for the Java LSP here
                    format = {
                        enabled = true,
                    },
                },
            },
        })

        require("lspconfig").ts_ls.setup({
            root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            single_file_support = true,
        })

        require("lspconfig").eslint.setup({
            root_dir = require("lspconfig.util").root_pattern(".eslintrc.js", ".git"),
        })

        require("lspconfig").html.setup({
            root_dir = require("lspconfig.util").root_pattern("index.html", ".git"),
            capabilities = capabilities, -- Optional, if you want to use any additional capabilities
        })

        require("lspconfig").cssls.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        require("lspconfig").pyright.setup({
            capabilities = { offsetEncoding = "utf-8" },
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "strict",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })

        require("lspconfig").sqls.setup({
            on_attach = function(client, bufnr)
                -- disable sqls formatting to prevent conflicts
                client.server_capabilities.documentFormattingProvider = false
            end,
            settings = {
                sqls = {
                    connections = {
                        {
                            driver = "sqlite3",
                            dataSourceName = "bro.db",
                        },
                    },
                },
            },
        })
        -- local servers = {
        -- }
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                spacing = 2,
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                source = "always",
                border = "rounded",
            },
        })
        vim.o.updatetime = 300
        -- vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])
    end,
}
