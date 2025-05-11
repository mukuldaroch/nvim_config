return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local nvim_tree = require("nvim-tree")

        -- Custom key mappings for nvim-tree
        local function on_attach(bufnr)
            local api = require("nvim-tree.api")
            local opts = { noremap = true, silent = true, nowait = true, buffer = bufnr }

            -- Custom navigation like Yazi
            vim.keymap.set("n", "l", api.node.open.edit, opts)             -- Open file/folder
            vim.keymap.set("n", "h", api.node.navigate.parent_close, opts) -- Close folder
            vim.keymap.set("n", "<CR>", api.node.open.edit, opts)          -- Keep Enter working
            -- Exit nvim-tree with 'q'
            vim.keymap.set("n", "q", api.tree.close, opts)
        end

        -- Setup nvim-tree with additional settings
        nvim_tree.setup({
            on_attach = on_attach, -- Attach custom key mappings
            filters = {
                dotfiles = false,
            },
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            hijack_unnamed_buffer_when_opening = false,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                adaptive_size = false,
                side = "right",
                width = 30,
                preserve_window_proportions = true,
                number = false,         -- No line numbers
                relativenumber = false, -- No relative numbers
                signcolumn = "no",      -- Hide sign column (removes ~)
            },
            git = {
                enable = true,
                ignore = true,
            },
            filesystem_watchers = {
                enable = true,
            },
            actions = {
                open_file = {
                    resize_window = true,
                    quit_on_open = true, -- Auto close nvim-tree when opening a file
                },
            },
            renderer = {
                root_folder_label = false,
                highlight_git = false,
                highlight_opened_files = "none",
                indent_markers = {
                    enable = true,
                },
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                    git_placement = "after",
                    glyphs = {
                        default = "󰈚",
                        symlink = "",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                            symlink_open = "",
                            arrow_open = "",
                            arrow_closed = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = " ",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
            },
        })

        -- Keymaps for toggling nvim-tree
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }

        keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)    -- Toggle tree
        keymap("n", "<leader>er", ":NvimTreeRefresh<CR>", opts)  -- Refresh tree
        keymap("n", "<leader>ef", ":NvimTreeFindFile<CR>", opts) -- Find current file in tree
    end,
}
