local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }

map("n", "<Space>", "<Nop>", silent)
