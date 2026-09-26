local config = require("config")
local theme = config.theme
local colors = theme.color

return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		options = {
			transparent = false,
			styles = { comments = "italic" },
		},
		colors = {
			palette = {
				-- Nightfox uses these named palette slots for its dark surfaces.
				bg0 = colors.mantle,
				bg1 = colors.base,
				bg2 = colors.surface,
				bg3 = colors.surface,
				fg0 = colors.text,
				fg1 = colors.text,
				fg2 = colors.subtext,
				fg3 = colors.subtext,
				red = colors.red,
				green = colors.green,
				yellow = colors.yellow,
				blue = colors.blue,
				magenta = colors.mauve,
				cyan = colors.blue,
				comment = colors.subtext,
				sel0 = colors.surface,
				sel1 = colors.surface,
			},
		},
		specs = {
			nightfox = {
				syntax = {
					variable = "fg1",
					ident = "fg1",
					field = "blue",
					type = "green",
					builtin1 = "cyan",
					func = "blue",
					keyword = "magenta",
					conditional = "magenta",
					string = "green",
					const = "yellow",
					number = "yellow",
					comment = "comment",
				},
			},
		},
	},
	config = function(_, opts)
		require("nightfox").setup(opts)
		vim.o.background = theme.background
		vim.cmd.colorscheme(theme.style)
	end,
}
