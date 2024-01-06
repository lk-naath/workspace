setup = {}

function setup.global()
	local map = vim.api.nvim_set_keymap
	local silent = { silent = true, noremap = true }

	map("n", "<Space>", "<Nop>", silent)
end

function setup.telescope(telescope)
	vim.keymap.set("n", "<leader>ff", telescope.builtin.find_files, {})
	vim.keymap.set("n", "<leader>fg", telescope.builtin.live_grep, {})
	vim.keymap.set("n", "<leader>fb", telescope.builtin.buffers, {})
	vim.keymap.set("n", "<leader>fh", telescope.builtin.help_tags, {})
end

return {
	setup = setup,
}
