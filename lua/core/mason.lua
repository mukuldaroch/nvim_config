return {
    "williamboman/mason.nvim",
    opt = {
        registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
        },
    },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "eslint_d", -- scan source code looking for errors
                "lua_ls", -- Lua
                "html",
                "cssls",
                "tsserver",
                -- Installed
                -- ◍ jdtls
                -- ◍ yamlfmt (keywords: yaml)
                -- ◍ lemminx
                -- ◍ sqls
                -- ◍ css - lsp
                -- ◍ cssmodules - language - server
                -- ◍ eslint - lsp
                -- ◍ eslint_d
                -- ◍ html - lsp
                -- ◍ htmlhint
                -- ◍ lua - language - server
                -- ◍ marksman
                -- ◍ prettier
                -- ◍ pyright
                -- ◍ stylelint
                -- ◍ stylua
                -- ◍ typescript - language - server
                --   marksman
            },
        })
        mason_tool_installer.setup({
            ensure_installed = {
                -- "prettier", -- prettier formatter
                -- "stylua", -- lua formatter
                -- "isort", -- python formatter
                -- "black", -- python formatter
                -- "mypy", -- static type checker
                -- "ruff", -- Python linter and code formatter
            },
        })

        require("mason").setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua", -- Used to format Lua code
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
