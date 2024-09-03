return {
	"goolord/alpha-nvim",
	priority = 1000,
	config = function()
		require("alpha").setup(require("alpha.themes.dashboard").config)
	end,
}
