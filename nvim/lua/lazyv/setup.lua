--- colorscheme
local catppuccin = require("plugins.colorscheme.catppuccin")

--- keybinding
local whichkey = require("plugins.keybinding.which-key")

--- explorer
local nvimtree = require("plugins.explorer.nvim-tree")

--- LSP
local mason = require("plugins.LSP.mason")
local cmp = require("plugins.LSP.cmp")

--- Fuzzy Finder
local telescope = require("plugins.fuzzyfind.telescope")

--- Git
local gitsigns = require("plugins.Git.gitsigns")

--- Status Line
local lualine = require("plugins.statusline.lualine")

--- formatters
local neoformat = require("plugins.formatter.neoformat")
local treesitter = require("plugins.syntax.treesitter")

local plugins = {
	mason,
	cmp,
	telescope,
	gitsigns,
	nvimtree,
	treesitter,
	catppuccin,
	whichkey,
	lualine,
	neoformat,
}

if vim.g.vscode then
	plugins = {
		telescope,
		whichkey,
		catppuccin,
	}
end

require("lazy").setup(plugins)
