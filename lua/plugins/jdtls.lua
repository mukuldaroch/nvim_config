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
        -- Full Lombok + JDTLS Config
        -- =========================
        local config = {
            cmd = {
                "java",
                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=ALL",
                "-Xmx2g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens",
                "java.base/java.util=ALL-UNNAMED",
                "--add-opens",
                "java.base/java.lang=ALL-UNNAMED",

                -- Lombok Agent
                "-javaagent:"
                    .. home
                    .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",

                -- JDTLS launcher
                "-jar",
                vim.fn.glob(
                    home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
                ),

                -- Linux config
                "-configuration",
                home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",

                -- Workspace per project
                "-data",
                workspace_dir,
            },

            -- Root dir detection (Gradle)
            root_dir = require("jdtls.setup").find_root({
                ".git",
                "gradlew",
                "build.gradle",
            }),

            -- =========================
            -- Java Language Settings
            -- =========================
            settings = {
                java = {
                    signatureHelp = { enabled = true },
                    extendedClientCapabilities = extendedClientCapabilities,
                    referencesCodeLens = { enabled = true },
                    references = { includeDecompiledSources = true },
                    inlayHints = { parameterNames = { enabled = "all" } },
                    format = { enabled = false }, -- disable LSP formatting
                    projectSources = {
                        vim.fn.getcwd() .. "/src/main/java",
                        vim.fn.getcwd() .. "/build/generated/sources/annotationProcessor/java/main",
                    },
                },
            },

            init_options = {
                bundles = {},
            },
        }

        -- =========================
        -- Start or Attach JDTLS
        -- =========================
        jdtls.start_or_attach(config)
    end,
}
