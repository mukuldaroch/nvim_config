return {
	"nanozuki/tabby.nvim",
	event = "VimEnter",
	config = function()
		-- shorten long file paths
		local filename = function(buf)
			local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":.")
			if name == "" then
				return "[No Name]"
			end
			return vim.fn.pathshorten(name, 3)
		end

		local theme = {
			fill = "TabLineFill",
			current = "TabLineSel",
			tab = "TabLine",
		}

		require("tabby.tabline").set(function(line)
			return {

				{
					line.tabs().foreach(function(tab)
						return {
							" " .. tab.number() .. " ",
							hl = tab.is_current() and theme.current or theme.tab,
						}
					end),
				},

				{
					" " .. filename(vim.api.nvim_get_current_buf()) .. " ",
					hl = "TabLineTransparent",
				},

				line.spacer(),

				{
					line.tabs().foreach(function(tab)
						local win = tab.current_win()
						local buf = win.buf().id
						local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t") -- filename only

						if name == "" then
							name = "[No Name]"
						end

						return {
							" " .. name .. " ",
							hl = tab.is_current() and theme.current or theme.tab,
							margin = " ",
						}
					end),
				},

				hl = theme.fill,
			}
		end)

		vim.o.showtabline = 2

		-- Fix all the ugly highlight issues
		vim.cmd([[
      highlight TabLineFill guibg=NONE
      highlight TabLine guibg=NONE guifg=#888888
      highlight TabLineSel guibg=#5f00af guifg=#ffffff gui=bold
      highlight TabLineTransparent guibg=NONE guifg=#bbbbbb
    ]])
	end,
}
