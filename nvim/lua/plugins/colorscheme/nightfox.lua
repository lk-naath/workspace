local config = require("config")
local theme = config.theme

return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	config = function(_, opts)
		vim.o.background = theme.background
		vim.cmd.colorscheme(theme.style)
	end,
}
