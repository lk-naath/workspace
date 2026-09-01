local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

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
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = "100"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect"

-- Status Line
opt.laststatus = 3

-- WhichKey
vim.o.timeout = true
vim.o.timeoutlen = 500
