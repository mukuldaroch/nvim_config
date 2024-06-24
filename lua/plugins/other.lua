
return{
	{'Mofiqul/dracula.nvim'},
	{"EdenEast/nightfox.nvim"},
	{ "nvim-neotest/nvim-nio" },
	{'feline-nvim/feline.nvim'}, --stylish and customizable statusline
	{"nvim-lua/plenary.nvim"},
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add          = { text = '+' },
				change       = { text = '~' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
		},
	},

}

