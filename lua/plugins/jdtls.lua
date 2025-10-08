return {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
        local home = os.getenv("HOME")
        local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = workspace_path .. project_name

        local status, jdtls = pcall(require, "jdtls")
        if not status then
            return
        end

        local extendedClientCapabilities = jdtls.extendedClientCapabilities

        -- =========================
        -- 🧩 Full Lombok + JDTLS Config
        -- =========================
        local config = {
            cmd = {
                "java",
                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=ALL",
                "-Xmx1g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens",
                "java.base/java.util=ALL-UNNAMED",
                "--add-opens",
                "java.base/java.lang=ALL-UNNAMED",

                -- ✅ Lombok Agent for Annotation Magic
                "-javaagent:"
                    .. home
                    .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",

                -- ✅ JDTLS launcher .jar
                "-jar",
                vim.fn.glob(
                    home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
                ),

                -- ✅ Correct configuration for Linux
                "-configuration",
                home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",

                -- ✅ Workspace per project
                "-data",
                workspace_dir,
            },

            -- ✅ Root dir detection
            root_dir = require("jdtls.setup").find_root({
                ".git",
                "mvnw",
                "gradlew",
                "pom.xml",
                "build.gradle",
            }),

            -- =========================
            -- ⚙️ Java Language Settings
            -- =========================
            settings = {
                java = {
                    signatureHelp = { enabled = true },
                    extendedClientCapabilities = extendedClientCapabilities,
                    maven = { downloadSources = true },
                    referencesCodeLens = { enabled = true },
                    references = { includeDecompiledSources = true },
                    inlayHints = { parameterNames = { enabled = "all" } },
                    format = { enabled = false }, -- disable LSP formatting (use prettier etc)
                },
            },

            init_options = {
                bundles = {},
            },
        }

        -- =========================
        -- 🚀 Start or Attach JDTLS
        -- =========================
        jdtls.start_or_attach(config)

        -- =========================
        -- 🧠 Java Keymaps
        -- =========================
        vim.keymap.set(
            "n",
            "<leader>co",
            "<Cmd>lua require'jdtls'.organize_imports()<CR>",
            { desc = "Organize Imports" }
        )
        vim.keymap.set(
            "n",
            "<leader>crv",
            "<Cmd>lua require('jdtls').extract_variable()<CR>",
            { desc = "Extract Variable" }
        )
        vim.keymap.set(
            "v",
            "<leader>crv",
            "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
            { desc = "Extract Variable" }
        )
        vim.keymap.set(
            "n",
            "<leader>crc",
            "<Cmd>lua require('jdtls').extract_constant()<CR>",
            { desc = "Extract Constant" }
        )
        vim.keymap.set(
            "v",
            "<leader>crc",
            "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
            { desc = "Extract Constant" }
        )
        vim.keymap.set(
            "v",
            "<leader>crm",
            "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
            { desc = "Extract Method" }
        )

    end,
}
