return {
    "rebelot/heirline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local conditions = require("heirline.conditions")

        vim.opt.laststatus = 0

        ----------------------------------------------------------------------
        -- 🔹 THEME (single source of truth)
        ----------------------------------------------------------------------

        local theme = {
            bg = "#1e1e2e",
            fg = "#cdd6f4",

            txt = "#000000",
            normal = "#35beff",
            insert = "#a6e3a1",
            visual = "#cba6f7",
            command = "#f9e2af",
            replace = "#ff5555",
            git = "#878787",
        }

        local function get_mode_color()
            local mode = vim.fn.mode(1)

            if mode == "n" then
                return theme.normal
            end
            if mode == "i" then
                return theme.insert
            end
            if mode == "v" or mode == "V" or mode == "\22" then
                return theme.visual
            end
            if mode == "c" then
                return theme.command
            end
            if mode == "R" then
                return theme.replace
            end

            return theme.normal
        end

        ----------------------------------------------------------------------
        -- 🔹 MACRO RECORDING
        ----------------------------------------------------------------------
        local Recording = {
            provider = function()
                local reg = vim.fn.reg_recording()
                if reg == "" then
                    return ""
                end
                return "  @" .. reg .. " "
            end,
            hl = { fg = "#ff5555", bold = true },
        }

        vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
            callback = function()
                require("heirline").eval_statusline()
            end,
        })

        ----------------------------------------------------------------------
        -- 🔹 MODE
        ----------------------------------------------------------------------
        local ViMode = {
            init = function(self)
                self.mode = vim.fn.mode(1)
            end,

            static = {
                names = {
                    n = "NORMAL",
                    i = "INSERT",
                    v = "VISUAL",
                    V = "V-LINE",
                    ["\22"] = "V-BLOCK",
                    c = "COMMAND",
                    R = "REPLACE",
                },
            },

            provider = function(self)
                return " " .. (self.names[self.mode] or self.mode) .. " "
            end,

            hl = function()
                return {
                    fg = theme.txt,
                    bg = get_mode_color(),
                    bold = true,
                }
            end,
        }

        ----------------------------------------------------------------------
        -- 🔹 DIAGNOSTICS
        ----------------------------------------------------------------------
        local Diagnostics = {
            condition = function()
                return vim.diagnostic.get(0) ~= nil
            end,

            {
                provider = function()
                    local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                    return count > 0 and ("  " .. count) or ""
                end,
                hl = { fg = "#ff5555" }, -- red
            },

            {
                provider = function()
                    local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                    return count > 0 and ("  " .. count) or ""
                end,
                hl = { fg = "#cba6f7" }, -- purple (your visual color)
            },

            {
                provider = function()
                    local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                    return count > 0 and ("  " .. count) or ""
                end,
                hl = { fg = "#f9e2af" }, -- yellow
            },

            {
                provider = function()
                    local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                    return count > 0 and ("  " .. count) or ""
                end,
                hl = { fg = "#a6e3a1" }, -- green
            },

            {
                provider = " ", -- spacing at end
            },
        }

        ----------------------------------------------------------------------
        -- 🔹 FILE
        ----------------------------------------------------------------------
        local FileName = {
            init = function(self)
                self.filename = vim.fn.expand("%:t")
            end,
            provider = function(self)
                if self.filename == "" then
                    return "[No Name]"
                end
                return " " .. self.filename .. " "
            end,
            hl = { fg = theme.fg, bg = theme.bg },
        }

        local FileIcon = {
            init = function(self)
                local filename = vim.fn.expand("%:t")
                local ext = vim.fn.expand("%:e")
                local icon, color = require("nvim-web-devicons").get_icon_color(filename, ext)
                self.icon = icon
                self.icon_color = color
            end,
            provider = function(self)
                return self.icon and (" " .. self.icon .. " ") or ""
            end,
            hl = function(self)
                return { fg = self.icon_color or theme.fg, bg = theme.bg }
            end,
        }

        local FileType = {
            provider = function()
                return " " .. vim.bo.filetype .. " "
            end,
            hl = { fg = theme.fg, bg = theme.bg },
        }

        ----------------------------------------------------------------------
        -- 🔹 GIT
        ----------------------------------------------------------------------
        local Git = {
            condition = conditions.is_git_repo,
            provider = function()
                local head = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head
                return head and ("  " .. head .. " ") or ""
            end,
            hl = { fg = theme.git },
        }

        local Diff = {
            condition = conditions.is_git_repo,
            provider = function()
                local g = vim.b.gitsigns_status_dict
                if not g then
                    return ""
                end
                return string.format(" +%d ~%d -%d ", g.added or 0, g.changed or 0, g.removed or 0)
            end,
            hl = { fg = theme.fg, bg = theme.bg },
        }
        ----------------------------------------------------------------------
        -- 🔹 LSP
        ----------------------------------------------------------------------

        local function get_lsp_name()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
                return ""
            end
            return " " .. clients[1].name .. " "
        end

        local Lsp = {
            provider = get_lsp_name,
            hl = { fg = theme.fg, bg = theme.bg },
        }

        ----------------------------------------------------------------------
        -- 🔹 POSITION
        ----------------------------------------------------------------------
        local Ruler = {
            provider = " %l:%c ",
            hl = function()
                return { fg = theme.txt, bg = get_mode_color() }
            end,
        }

        local Percent = {
            provider = " %p%% ",
            hl = function()
                return { fg = theme.txt, bg = get_mode_color() }
            end,
        }

        ----------------------------------------------------------------------
        -- 🔥 STATUSLINE
        ----------------------------------------------------------------------
        require("heirline").setup({
            statusline = {
                -- LEFT
                {
                    ViMode,
                    {
                        provider = "",
                        hl = function()
                            return { fg = get_mode_color(), bg = theme.bg }
                        end,
                    },
                },

                {
                    FileType,
                    { provider = "", hl = { fg = theme.fg, bg = theme.bg } },
                },

                {
                    FileIcon,
                    FileName,
                    {
                        provider = "",
                        hl = { fg = theme.bg, bg = "none" },
                    },
                    Diagnostics,
                    hl = function()
                        return { bg = "none" }
                    end,
                },

                { provider = "%=" },

                -- RIGHT
                Recording,

                Git,
                {
                    {
                        provider = "",
                        hl = function()
                            return { fg = theme.bg, bg = "none" }
                        end,
                    },
                    Diff,
                    { provider = "", hl = { fg = theme.fg, bg = theme.bg } },
                },

                {
                    Lsp,
                    {
                        provider = "",
                        hl = function()
                            return { fg = get_mode_color(), bg = theme.bg }
                        end,
                    },
                    Percent,

                    {
                        provider = "",
                        hl = function()
                            return { fg = theme.txt, bg = get_mode_color() }
                        end,
                    },
                    Ruler,
                },
            },
        })
    end,
}
