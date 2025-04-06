return {
    "akinsho/toggleterm.nvim",
    config = function()
        -- Load the toggleterm plugin
        require("toggleterm").setup({})
        local Terminal = require("toggleterm.terminal").Terminal

        -------------------------------------------------------------------------------
        -- Create a cached terminal instance for general use
        local terminal = Terminal:new({
            shell = vim.o.shell,
            direction = "float",
            float_opts = {
                border = { "", "", "", "", "", "", "", "│" },
                -- width = math.floor(vim.o.columns * 0.4),
                -- height = vim.o.lines,
                -- col = vim.o.columns - math.floor(vim.o.columns * 0.4),
                -- row = 0,
            },
        })
        -------------------------------------------------------------------------------
        -- Create a cached terminal instance for general use
        local music = Terminal:new({
            shell = vim.o.shell,
            direction = "float",
            float_opts = {
                border = { "", "", "", "", "", "", "", "│" },
                -- width = math.floor(vim.o.columns * 0.4),
                -- height = vim.o.lines,
                -- col = vim.o.columns - math.floor(vim.o.columns * 0.4),
                -- row = 0,
            },
            on_open = function(term)
                term:send("z music && y")
            end,
        })
        -------------------------------------------------------------------------------

        -- Function to open lazygit in a full-screen terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
            float_opts = {
                border = "none",
                width = vim.o.columns, -- Convert to integer
                height = vim.o.lines, -- Convert to integer
            },
            on_open = function(term)
                vim.cmd("startinsert!") -- Start in insert mode
                vim.api.nvim_buf_set_keymap(
                    term.bufnr,
                    "t",
                    "<esc>",
                    "<C-\\><C-n>:q<CR>",
                    { noremap = true, silent = true }
                )
            end,
        })

        -------------------------------------------------------------------------------
        -- Function to run Python file in a full-screen terminal
        function _G.run_code_fullscreen()
            local extension = vim.fn.expand("%:e")
            local file = vim.fn.bufname("%")
            local command

            if extension == "py" then
                command = "clear && py " .. file
            elseif extension == "java" then
                command = "clear && java " .. file
            elseif extension == "cpp" then
                command = "clear && g++ " .. file .. " && ./a.out"
            elseif extension == "c" then
                command = "clear && clang " .. file .. " && ./a.out"
            elseif extension == "md" then
                command = "clear && glow " .. file
                -- also can use glow --width 50
            elseif extension == "html" then
                command = "clear && brave " .. file
            elseif extension == "css" then
                command = "clear && brave " .. file
            elseif extension == "js" then
                command = "clear && brave " .. file
            else
                command = "clear"
                -- automatically opens the terminal
            end
            -- Reuse the general terminal for running Python
            local vertical_terminal = Terminal:new({
                direction = "float",
                float_opts = {
                    border = { "", "─", "", "", "", "─", "", "" },
                    width = vim.o.columns,
                    height = vim.o.lines,
                    row = 0,
                },
                on_open = function(term)
                    term:send(command)
                end,
            })
            vertical_terminal:toggle()
        end

        -------------------------------------------------------------------------------
        -- Function to run Python or C/C++ files in a vertical terminal
        function _G.run_code_in_vertical_terminal()
            local extension = vim.fn.expand("%:e")
            local file = vim.fn.bufname("%")
            local command

            if extension == "py" then
                command = "clear && py " .. file
            elseif extension == "java" then
                command = "clear && java " .. file
            elseif extension == "cpp" then
                command = "clear && g++ " .. file .. " && ./a.out"
            elseif extension == "c" then
                command = "clear && clang " .. file .. " && ./a.out"
            elseif extension == "md" then
                command = "clear && glow --width 60 " .. file
            else
                command = "clear"
            end

            local vertical_terminal = Terminal:new({
                shell = vim.o.shell,
                direction = "float",
                float_opts = {
                    border = { "", "", "", "", "", "", "", "│" },
                    width = math.floor(vim.o.columns * 0.4),
                    height = vim.o.lines,
                    col = vim.o.columns - math.floor(vim.o.columns * 0.4),
                    row = 0,
                },
                on_open = function(term)
                    term:send(command)
                end,
            })
            vertical_terminal:toggle()
        end

        -------------------------------------------------------------------------------
        -- Function to toggle the general terminal
        function _G.toggle_terminal()
            terminal:toggle()
        end

        -- Function to toggle the music in yazi
        function _G.toggle_music()
            music:toggle()
        end

        -- Function to toggle Lazygit
        function _G.toggle_lazygit()
            lazygit:toggle()
        end

        -------------------------------------------------------------------------------

        -- Keybindings
        vim.api.nvim_set_keymap("n", "<leader>t", ":lua toggle_terminal ()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>m", ":lua toggle_music()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>l", ":lua toggle_lazygit()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>i", ":lua run_code_fullscreen()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap(
            "n",
            "<leader>r",
            ":lua run_code_in_vertical_terminal()<CR>",
            { noremap = true, silent = true }
        )
    end,
}
