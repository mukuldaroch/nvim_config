return {
    "rebelot/heirline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local conditions = require("heirline.conditions")

        -- tpipeline fix
        vim.opt.laststatus = 0

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
            hl = { fg = "#ff5555", bg = "none", bold = true },
        }
        vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
            callback = function()
                require("heirline").eval_statusline()
            end,
        })

        ----------------------------------------------------------------------
        -- COLORS
        ----------------------------------------------------------------------
        local colors = {
            bg = "#1e1e2e",
            fg = "#cdd6f4",
            blue = "#35beff",
            green = "#a6e3a1",
            yellow = "#f9e2af",
        }
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
            hl = { fg = colors.bg, bg = colors.blue, bold = true },
        }

        ----------------------------------------------------------------------
        -- 🔹 SEPARATORS (REUSABLE)
        ----------------------------------------------------------------------

        local function SepLeft()
            return {
                provider = "",
                hl = { fg = colors.fg, bg = colors.bg },
            }
        end

        local function ArrowLeft(color_from, color_to)
            return {
                provider = "",
                hl = { fg = colors.blue, bg = "#1e1e2e" },
            }
        end
        local function ArrowLeft2(color_from, color_to)
            return {
                provider = "",
                hl = { fg = "#1e1e2e", bg = "none" },
            }
        end

        local function SepRight()
            return {
                provider = "",
                hl = { fg = colors.fg, bg = colors.bg },
            }
        end

        local function ArrowRight(color_from, color_to)
            return {
                provider = "",
                hl = { fg = colors.bg, bg = "none" },
            }
        end

        local function ArrowRight2(color_from, color_to)
            return {
                provider = "",
                hl = { fg = colors.blue, bg = colors.bg },
            }
        end

        ----------------------------------------------------------------------
        -- 🔹 FILE ICON + NAME
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
            hl = { fg = colors.fg, bg = colors.bg },
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
                return { fg = self.icon_color or colors.fg, bg = colors.bg }
            end,
        }

        ----------------------------------------------------------------------
        -- 🔹 FILETYPE
        ----------------------------------------------------------------------
        local FileType = {
            provider = function()
                return " " .. vim.bo.filetype .. " "
            end,
            hl = { fg = colors.yellow, bg = colors.bg },
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
            hl = { fg = colors.green, bg = "none" },
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
            hl = { fg = colors.yellow, bg = colors.bg },
        }

        ----------------------------------------------------------------------
        -- 🔹 POSITION
        ----------------------------------------------------------------------
        local Ruler = {
            provider = " %l:%c ",
            hl = { fg = "black", bg = colors.blue },
        }

        local Percent = {
            provider = " %p%% ",
            hl = { fg = colors.fg, bg = colors.bg },
        }

        ----------------------------------------------------------------------
        -- 🔥 STATUSLINE (COMPOSE EVERYTHING)
        ----------------------------------------------------------------------
        require("heirline").setup({
            statusline = {
                -- LEFT SIDE
                ViMode,
                ArrowLeft(),
                FileType,
                SepLeft(),
                FileIcon,
                FileName,
                ArrowLeft2(),

                { provider = "%=" },

                -- RIGHT SIDE
                Recording,
                Git,
                ArrowRight(),
                Diff,
                SepRight(),
                Percent,
                ArrowRight2(),
                Ruler,
            },
        })
    end,
}
