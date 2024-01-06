--- colorscheme
local nightfox = require("plugins.colorscheme.nightfox")

--- keybinding
local whichkey = require("plugins.keybinding.which-key")

--- explorer
local nvimtree = require("plugins.explorer.nvim-tree")

--- LSP
local mason = require("plugins.LSP.mason")
local lspconfig = require("plugins.LSP.lspconfig")
local masonlspconfig = require("plugins.LSP.masonlspconfig")

--- Completion
local nvimcmp = require("plugins.completion.nvim-cmp")

--- Fuzzy Finder
local telescope = require("plugins.fuzzyfind.telescope")

--- Git
local gitsigns = require("plugins.Git.gitsigns")

--- Status Line
local lualine = require("plugins.statusline.lualine")

--- formatters
local neoformat = require("plugins.formatter.neoformat")

require("lazy").setup({
	masonlspconfig,
	lspconfig,
	telescope,
	gitsigns,
	nvimtree,
	nightfox,
	whichkey,
	nvimcmp,
	mason,
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
