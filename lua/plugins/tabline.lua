return {
	"nanozuki/tabby.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local theme = {
			fill = "TabLineFill",
			head = "TabLine",
			current_tab = { fg = "#000000", bg = "#35beff", style = "italic" },

			-- vim.api.nvim_set_hl(0, "TabbyRedBG", { bg = "#0000" }),
			vim.api.nvim_set_hl(0, "TabbyRedBG", { bg = "#222222" }),
			tab = "TabLine",
			win = "TabLine",
			tail = "TabLine",
		}

		require("tabby.tabline").set(function(line)
			return {
				vim.cmd([[ highlight TabLineFill guibg=NONE ]]),
				{
					{ "", hl = theme.head },
				},

				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab

					return {
						line.sep(" ", "TabbyRedBG", hl),
						tab.number(),
						line.sep(" ", "TabbyRedBG", hl),
						line.sep("", hl, theme.fill),
						hl = hl,
					}
				end),
				line.spacer(),
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab

					return {
						-- Left triangle (same as before)
						line.sep("", hl, theme.fill),

						-- tab.number(),
						tab.name(),

						-- Right triangle: reverse the highlight + fill to color the glyph itself
						line.sep("", "TabbyRedBG", hl),

						hl = hl,
						margin = " ",
					}
				end),
				-- hl = theme.fill,
			}
		end)
		vim.o.showtabline = 2
	end,
}
-- return {
-- 	"nanozuki/tabby.nvim",
-- 	event = "VimEnter",
-- 	config = function()
-- 		local theme = {
-- 			fill = "TabLineFill", -- tabline background
-- 			head = "TabLine", -- head element highlight
-- 			current_tab = "TabLineSel", -- current tab label highlight
-- 			tab = "TabLine", -- other tab label highlight
-- 			win = "TabLine", -- window highlight
-- 			tail = "TabLine", -- tail element highlight
-- 		}
-- 		require("tabby.tabline").set(function(line)
-- 			return {
--
-- 				{
-- 					line.tabs().foreach(function(tab)
-- 						local win = tab.current_win()
-- 						local buf = win.buf().id
-- 						local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t") -- filename only
--
-- 						if name == "" then
-- 							name = "[No Name]"
-- 						end
--
-- 						return {
-- 							" " .. name .. " ",
-- 							hl = tab.is_current() and theme.current or theme.tab,
-- 							margin = " ",
-- 						}
-- 					end),
-- 				},
--
-- 				line.spacer(),
--
-- 				{
-- 					line.tabs().foreach(function(tab)
-- 						return {
-- 							" " .. tab.number() .. " ",
-- 							hl = tab.is_current() and theme.current or theme.tab,
-- 						}
-- 					end),
-- 				},
--
-- 				hl = theme.fill,
-- 			}
-- 		end)
--
-- 		vim.o.showtabline = 2
--
-- 		-- Fix all the ugly highlight issues
-- 		vim.cmd([[
--       highlight TabLineFill guibg=NONE
--       highlight TabLine guibg=NONE guifg=#888888
--       highlight TabLineSel guibg=#5f00af guifg=#ffffff gui=bold
--       highlight TabLineTransparent guibg=NONE guifg=#bbbbbb
--     ]])
-- 	end,
-- }
