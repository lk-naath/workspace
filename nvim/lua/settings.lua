--- line numbering ---
vim.o.nu = true
vim.o.rnu = true

--- tabs and spaces ---
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

--- defaults ---
vim.cmd("highlight clear", silent)
vim.cmd(vim.g.syntax_on and 'syntax reset' or '')
