--- colorscheme
local nightfox = require("plugins.colorscheme.nightfox")
local catppuccin = require("plugins.colorscheme.catppuccin")

--- keybinding
local whichkey = require("plugins.keybinding.which-key")

--- explorer
local nvimtree = require("plugins.explorer.nvim-tree")

--- LSP
local mason = require("plugins.LSP.mason")

--- Fuzzy Finder
local telescope = require("plugins.fuzzyfind.telescope")

--- Git
local gitsigns = require("plugins.Git.gitsigns")

--- Status Line
local lualine = require("plugins.statusline.lualine")

--- formatters
local neoformat = require("plugins.formatter.neoformat")

require("lazy").setup({
	mason,
	telescope,
	gitsigns,
	nvimtree,
  catppuccin,
	whichkey,
	lualine,
  neoformat
	--- build = {},
	--- checker = {},
	--- concurrency = {},
	--- defaults = {},
	--- dev = {},
	--- diff = {},
	--- git = {},
	--- install = {},
	--- lockfile = {},
	--- performance = {},
	--- profiling = {},
	--- readme = {},
	--- root = env.lazypath,
	--- spec = {},
	--- state = env.statepath,
	--- ui = {},
})
