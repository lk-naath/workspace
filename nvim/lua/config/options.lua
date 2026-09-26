local opt = vim.opt
local config = require("config")
local layout = config.theme.layout

-- Tab / Indentation
opt.tabstop = layout.indent.tabstop
opt.shiftwidth = layout.indent.shiftwidth
opt.softtabstop = layout.indent.softtabstop
opt.expandtab = layout.indent.expandtab
opt.smartindent = layout.indent.smartindent
opt.wrap = layout.wrap

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

if vim.g.vscode then
	-- VSCode Neovim can sometimes make the incremental search highlight too subtle.
	-- Re-apply the search options and make the active match visually obvious.
	vim.api.nvim_set_hl(0, "IncSearch", { bold = true, reverse = true })
	vim.api.nvim_set_hl(0, "CurSearch", { bold = true, reverse = true })
end

-- Appearance
opt.number = layout.line_numbers
opt.relativenumber = layout.relative_line_numbers
opt.termguicolors = true
opt.colorcolumn = tostring(layout.color_column)
opt.signcolumn = layout.sign_column
opt.cmdheight = layout.cmdheight
opt.scrolloff = layout.scrolloff
opt.completeopt = "menuone,noinsert,noselect"

-- Status Line
opt.laststatus = layout.laststatus

-- WhichKey
vim.o.timeout = true
vim.o.timeoutlen = 500
