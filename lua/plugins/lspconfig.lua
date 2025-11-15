return {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- Useful status updates for LSP.
        { "j-hui/fidget.nvim", opts = {} },

        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        "saghen/blink.cmp",
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Rename the variable under your cursor.
                map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

                -- Execute a code action, usually your cursor needs to be on top of an error
                map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

                -- Find references for the word under your cursor.
                map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                -- Jump to the definition of the word under your cursor.
                map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- Fuzzy find all the symbols in your current document.
                map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

                -- Fuzzy find all the symbols in your current workspace.
                map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

                ---@param client vim.lsp.Client
                ---@param method vim.lsp.protocol.Method
                ---@param bufnr? integer some lsp support methods only in specific files
                ---@return boolean
                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has("nvim-0.11") == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                -- word under your cursor when your cursor rests there for a little while.
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if
                    client
                    and client_supports_method(
                        client,
                        vim.lsp.protocol.Methods.textDocument_documentHighlight,
                        event.buf
                    )
                then
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

                if
                    client
                    and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

        -- Diagnostic Config
        vim.diagnostic.config({
            severity_sort = true,
            float = { border = "rounded", source = "if_many" },
            underline = { severity = vim.diagnostic.severity.ERROR },
            signs = vim.g.have_nerd_font and {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = "󰀪 ",
                    [vim.diagnostic.severity.INFO] = "󰋽 ",
                    [vim.diagnostic.severity.HINT] = "󰌶 ",
                },
            } or {},
            virtual_text = {
                source = "if_many",
                spacing = 2,
                format = function(diagnostic)
                    local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                    }
                    return diagnostic_message[diagnostic.severity]
                end,
            },
        })

        local capabilities = require("blink.cmp").get_lsp_capabilities()
        local servers = {

            clangd = {
                capabilities = {
                    offsetEncoding = { "utf-8" }, -- helps with some LSP encoding issues
                },
                filetypes = { "h", "c", "cpp", "objc", "objcpp" },
                single_file_support = true,
            },

            lua_ls = {
                cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" }, -- Use Mason's LSP
                capabilities = {
                    offsetEncoding = "utf-8",
                },
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            },
            marksman = {
                cmd = { vim.fn.stdpath("data") .. "/mason/bin/marksman" }, -- or just "marksman" if it's globally installed
                filetypes = { "markdown", "markdown.mdx" },
                capabilities = {
                    offsetEncoding = "utf-8",
                },
            },

            ts_ls = {
                root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                single_file_support = true,
            },
            --
            eslint = {
                root_dir = require("lspconfig.util").root_pattern(".eslintrc.js", ".git"),
            },
            --
            html = {
                root_dir = require("lspconfig.util").root_pattern("index.html", ".git"),
                capabilities = capabilities, -- Optional, if you want to use any additional capabilities
            },

            cssls = {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            },

            pyright = {
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
            },

            sqls = {
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
            },
            tailwindcss = {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
                init_options = {
                    userLanguages = {
                        javascript = "javascript",
                        typescript = "typescript",
                        javascriptreact = "javascript",
                        typescriptreact = "typescript",
                    },
                },
                root_dir = require("lspconfig").util.root_pattern(
                    "tailwind.config.js",
                    "tailwind.config.ts",
                    "postcss.config.js",
                    "package.json"
                ),
            },
            emmet_ls = {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "javascriptreact",
                    "typescriptreact",
                    -- anything with JSX basically
                },
                init_options = {
                    html = {
                        options = {
                            -- For React, you want `className` instead of `class`
                            ["bem.enabled"] = true,
                        },
                    },
                },
            },
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            ensure_installed = {},
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
