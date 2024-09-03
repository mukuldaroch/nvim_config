return {
	{
		-- Main DAP plugin
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui", -- DAP UI for visual debugging elements
			"theHamsta/nvim-dap-virtual-text", -- Inline variable values
			"nvim-neotest/nvim-nio", -- Neotest integration (optional, for testing)
			--"williamboman/mason.nvim", -- Mason for managing DAP servers
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			-- Setup the DAP UI
			require("dapui").setup()
			-- Setup virtual text for inline variable values
			require("nvim-dap-virtual-text").setup({})

			-- Example configuration for Elixir (not needed for Python, C++, Lua)
			-- local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
			-- if elixir_ls_debugger ~= "" then
			--     dap.adapters.mix_task = {
			--         type = "executable",
			--         command = elixir_ls_debugger,
			--     }
			--     dap.configurations.elixir = {
			--         {
			--             type = "mix_task",
			--             name = "phoenix server",
			--             task = "phx.server",
			--             request = "launch",
			--             projectDir = "${workspaceFolder}",
			--             exitAfterTaskReturns = false,
			--             debugAutoInterpretAllModules = false,
			--         },
			--     }
			-- end

			-- Setting up Python debugger
			dap.adapters.python = {
				type = "executable",
				command = "C:/Python312/pythonw.exe", -- Replace this with the path to your Python interpreter
				args = { "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}", -- This will debug the current file
					pythonPath = function()
						-- Use the Python interpreter from the command line if available
						local venv_path = os.getenv("VIRTUAL_ENV")
						if venv_path then
							return venv_path .. "C:/Python312/pythonw.exe"
						else
							return "C:/Python312/pythonw.exe" -- Replace this with the path to your Python interpreter
						end
					end,
				},
			}
			--[[
			-- C++ DAP configuration
			dap.adapters.cppdbg = {
				type = "executable",
				command = "path/to/cpptools/extension/debugAdapters/bin/OpenDebugAD7", -- Adjust to your setup
				id = "cppdbg",
			}
			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
					},
				},
			}

			-- Lua DAP configuration
			dap.adapters.lua = {
				type = "executable",
				command = "path/to/lua-debug/adapter/debugAdapter", -- Adjust to your Lua debugger path
				args = {},
			}
			dap.configurations.lua = {
				{
					name = "Launch",
					type = "lua",
					request = "launch",
					program = function()
						return vim.fn.input("Path to Lua script: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
--]]
			-- Keymaps for DAP commands
			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint) -- Toggle breakpoint
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor) -- Run to cursor
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end) -- Evaluate variable under cursor

			vim.keymap.set("n", "<space>d", dap.continue) -- Continue execution
			vim.keymap.set("n", "<F2>", dap.step_into) -- Step into function
			vim.keymap.set("n", "<F3>", dap.step_over) -- Step over function
			vim.keymap.set("n", "<F4>", dap.step_out) -- Step out of function
			vim.keymap.set("n", "<F5>", dap.step_back) -- Step back
			vim.keymap.set("n", "<F13>", dap.restart) -- Restart

			-- Open DAP UI on attach or launch
			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			-- Close DAP UI on termination or exit
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
