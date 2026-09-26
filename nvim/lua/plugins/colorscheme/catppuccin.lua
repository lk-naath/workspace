local config = require("config")
local theme = config.theme

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = { flavour = theme.style },
  config = function()
		vim.cmd.colorscheme("catppuccin")
		vim.o.background = theme.background
  end
}
