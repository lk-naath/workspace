return {
	"nvim-telescope/telescope.nvim",
	lazy = true,
	config = function()
		local telescope = require("telescope")
		local keymappings = require("config.keymappings")

		keymappings.setup.telescope(telescope)
	end,
}
